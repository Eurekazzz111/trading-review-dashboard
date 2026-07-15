const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

const html = fs.readFileSync(path.join(__dirname, "..", "index.html"), "utf8");
const start = html.indexOf("    function splitKlineCsvLine");
const end = html.indexOf("    function clearCanvas", start);
assert.ok(start >= 0 && end > start, "K-line parser source was not found");

const parserSource = html.slice(start, end);
const createParser = new Function(`
  function atasSourceToBeijing(day, time) {
    return {beijingDate:day, beijingTime:time, cmeTradingDate:day};
  }
  function beijingDateTimeMinutes(day, time) {
    return Date.parse(day + "T" + time + ":00Z") / 60000;
  }
  ${parserSource}
  return parseAtasCsv;
`);
const parseAtasCsv = createParser();

const timezoneStart = html.indexOf('    const DISPLAY_TIME_ZONE = "Asia/Shanghai"');
const timezoneEnd = html.indexOf("    function tradeCmeTradingDate", timezoneStart);
assert.ok(timezoneStart >= 0 && timezoneEnd > timezoneStart, "K-line timezone helpers were not found");
const timezoneSource = html.slice(timezoneStart, timezoneEnd);
const createTimezoneHelpers = new Function(`
  function normalizeDateValue(value) {
    const match = String(value || "").match(/^(\\d{4})-(\\d{1,2})-(\\d{1,2})/);
    return match ? match[1] + "-" + match[2].padStart(2, "0") + "-" + match[3].padStart(2, "0") : "";
  }
  ${timezoneSource}
  return {atasSourceToBeijing};
`);
const {atasSourceToBeijing} = createTimezoneHelpers();

const combined = parseAtasCsv([
  "2026-15-07 09:30:00;22100.25;22104.5;22098.75;22103.5",
  "2026-15-07 09:31:00;22103.5;22106;22102;22105.25"
].join("\n"));
assert.deepEqual(combined["2026-07-15"][0].slice(0, 5), ["09:30", 22100.25, 22104.5, 22098.75, 22103.5]);

const separateColumns = parseAtasCsv([
  "Date;Time;Open;High;Low;Close;Volume",
  "2026-07-15;09:30:00;22100.25;22104.5;22098.75;22103.5;120",
  "2026-07-15;09:31:00;22103.5;22106;22102;22105.25;95"
].join("\n"));
assert.equal(separateColumns._meta.headerFound, true);
assert.equal(separateColumns._meta.parsedRows, 2);
assert.equal(separateColumns["2026-07-15"].length, 2);

const decimalComma = parseAtasCsv([
  "日期;时间;开盘价;最高价;最低价;收盘价",
  "15.07.2026;09:30:00;22100,25;22104,50;22098,75;22103,50"
].join("\n"));
assert.equal(decimalComma["2026-07-15"][0][1], 22100.25);

const invalidShiftedColumns = parseAtasCsv("2026-07-15;09:30:00;22100;22105;22095");
assert.deepEqual(Object.keys(invalidShiftedColumns), []);
assert.equal(invalidShiftedColumns._meta.invalidRows, 1);

assert.deepEqual(atasSourceToBeijing("2026-07-15", "08:30", "beijing"), {
  beijingDate:"2026-07-15",
  beijingTime:"08:30",
  cmeTradingDate:"2026-07-15"
});
assert.deepEqual(atasSourceToBeijing("2026-07-15", "08:30", "chicago"), {
  beijingDate:"2026-07-15",
  beijingTime:"21:30",
  cmeTradingDate:"2026-07-15"
});

console.log("K-line parser tests passed");
