# Trading Review Dashboard

一个单文件交易复盘工作台，适合手动导入 CSV 做交易统计、策略复盘和 AI 复盘提示。

## 在线访问

如果使用 GitHub Pages 部署，地址格式通常是：

```text
https://Eurekazzz111.github.io/trading-review-dashboard/
```

如果仓库名不同，把上面的 `trading-review-dashboard` 换成你的仓库名。

## 文件说明

- `index.html`：网页正式入口，GitHub Pages 会默认打开这个文件。
- `trading-journal-simple-example.csv`：CSV 导入示例。
- `supabase-schema.sql`：Supabase 云端数据库建表和权限策略。
- `README.md`：项目说明。

## 当前功能

- 交易日志录入和 CSV 合并导入/导出：保留已有交易；新 ID 会追加，同 ID 或同交易签名会覆盖更新，用于修正已上传的错误记录
- 自动计算点数、美元盈亏、持仓时间、Risk/Reward
- 风险管理记录：初始止损、目标价、出场原因、管理标签、保护评价、后续是否到目标
- 自动计算 Realized R、平均 Realized R、总 Realized R、盈亏比和目标错失利润
- NQ 默认每点 20 美元，MNQ 默认每点 2 美元，ES 默认每点 50 美元，MES 默认每点 5 美元
- Profit Factor、Win Rate、数学期望、Average Win / Average Loss（亏损统一显示为红色）
- 完整绩效指标：Total/Net PnL、回撤日期、最大相对回撤、恢复因子、Gross/Total Profit & Loss、胜负天数、日均 PnL、最佳/最差交易、日度 Sharpe、日均笔数和最长连胜/连负
- 每日总记录、周统计、月历统计
- 总览月历联动每日总结和每日交易记录：默认显示最新交易日；点击日历日期后，只切换下方空白总结输入框和当天交易记录，不跳转交易日志；总结由用户手写，不自动生成
- 累计盈亏曲线、每日盈亏柱状图
- K 线图：导入 ATAS 当日 K 线 CSV，按表头识别日期、时间和 OHLC，兼容日期时间合并列或分列；导入前可选择 CSV 使用北京时间或 CME/Chicago 时间，支持 1m / 5m 切换和鼠标滚轮缩放
- K 线历史按年份/月归档，每次只排列当月有交易的日期，适合持续记录数月或数年
- 按策略、盘段、方向、纪律执行统计
- 开单位置记录与统计：按位置显示样本数、胜率、Profit Factor、数学期望和净盈亏
- 入场信号、入场点位选择原因记录；规则违规标签和情绪原因记录
- 破规则由人工手动标记（不再按执行评分自动推断）；备注可记录任何补充内容
- 策略手册支持手动维护关键词；左侧策略列表、右侧关键词复习和核心分析会同步显示，并保持同一关键词同一颜色
- 策略手册支持在关键词复习下方保存模型截图，用来归档相似形态、进出场模型和复盘示例
- 策略学习页：按大策略分类记录大段思考、反思、新知识和格外注意点，方便持续复习
- 策略手册关键词改为手动填写并同步显示；相同关键词在不同区域保持同色，方便复习
- 响应式布局，手机和平板可用；数据表数字右对齐、等宽对齐
- 策略手册、核心分析、AI 复盘提示
- Supabase 邮箱密码登录和云端同步

## 最近更新

- 新增 `recordType` 记录类型：默认统计只看实盘，复盘回放、模拟盘、假设修正和观察案例需要切换筛选后查看，避免干扰实盘账本。
- 登录方式改为邮箱 + 密码；浏览器可记住密码，换设备后输入同一邮箱和密码即可同步云端数据。
- 策略手册新增模型截图板块：上传后会压缩并保存在当前策略中，随策略手册一起同步。
- 交易日志支持自动保存和不完整记录保存；缺失字段不阻止记录进入总笔数，只会跳过对应指标的计算。
- 策略手册关键词改为手动输入，不再从策略长文自动提炼；保存后会随策略手册一起同步。
- 同一个关键词在策略列表、关键词复习和核心分析中使用固定颜色，方便区分和复盘。
- 新增 `策略学习` 页面：按大策略分类记录大段思考、反思、新知识和格外注意点。
- 新增 `strategy_learning_notes` 云端表：邮箱密码登录后，策略学习记录可跨设备同步。
- K 线数据已从本机缓存升级为云端同步：ATAS K 线 CSV 导入后会写入 `kline_days` 表。
- K 线图支持按交易顺序标注进出场，并在下方列出对应交易的策略、入场信号、入场点位选择原因和备注。
- 交易数据、策略手册、策略学习记录、设置和 K 线数据都支持 Supabase 云端保存。
- 新增交易管理字段：`targetPrice`、`exitReason`、`managementTag`、`managementReview`、`targetReached`。
- 总览和核心分析新增 Realized R、盈亏比、目标错失利润统计。
- 交易日志策略字段支持从现有策略下拉选择，同时保留手动输入新策略。
- 策略关键词不再自动提炼，改为只同步显示手动填写的关键词，并用稳定颜色区分。
- K 线图 1m / 5m 切换、鼠标滚轮缩放、方向箭头进出场标记和亏损交易红色编号已上线。
- K 线页面只列出有交易且已导入 K 线的日期；无交易日不再显示空 K 线图或订单轨迹。
- K 线日期导航改为按年月归档和当月交易日网格，跨月、跨年记录仍能保持整齐。
- 未登录时的 K 线数据从 `localStorage` 自动迁移到 IndexedDB，提升多年 1 分钟历史数据的本机容量；Supabase 云端表结构保持不变。
- 新增 `entryLocation` 开单位置字段：可复用历史位置名称，主页按位置统计胜率、PF、期望和样本状态。
- 交易明细、当日 AI 复盘和 K 线图下方的当日交易记录会同步显示开单位置。
- 备注改为通用自由记录，不再要求只在破规则时填写。
- 新增每笔 `fees` 手续费与自动计算的 `netPnl`；胜率、PF、回撤、图表和复盘统一使用净盈亏。
- 设置新增起始账户余额，用于准确计算最大相对回撤；未设置时该指标显示 `-`。
- 总览新增截图所列的完整绩效指标，并补充 Recovery Factor、日度 Sharpe、日均交易频率和连续胜负。
- 总览新增手写每日总结：月历选择日期后，下方显示该日期的空白总结输入框，内容自动保存并随云端设置同步；点击日期不再跳转到交易日志。
- 总览新增每日交易记录卡片：默认显示最新交易日，点击月历日期后同步显示当天交易；持仓时间对比移到更下方统计区。
- K 线图上方同步显示当前 K 线日期的手写每日总结；未填写时保持空白，不自动生成复盘文字。

## CSV 格式

导入采用增量 upsert：CSV 中的新 ID 会追加；重复 ID 会覆盖更新原记录；没有 ID 但日期、进出场时间、品种、方向、入场价、出场价相同的记录，也会按同一笔交易覆盖更新。这样可以重新上传修正版 CSV 来修正已上传的错误记录，同时不会清空其它历史记录。建议每笔交易使用稳定且唯一的 `id`。

推荐字段：

```csv
id,recordType,date,entryTime,exitTime,session,dayPart,symbol,side,strategy,entryLocation,entry,initialStop,targetPrice,exit,riskReward,realizedR,targetReached,pnl,fees,netPnl,qty,grade,exitReason,managementTag,managementReview,ruleBroken,ruleViolation,emotionCause,entrySignal,entryReason,notes
```

示例：

```csv
T2001,live,2026-06-18,09:35,10:05,美盘,早盘,NQ,Long,Opening Drive,VAH,22000,21980,22050,22050,2.50,2.50,true,2000,8,1992,2,5,到目标,按计划持有,无需评价,false,,,5m 收回开盘高点,前一日 VAH 上方回踩不破,按计划执行
```

字段说明：

- `date`：交易的北京时间日期，格式 `YYYY-MM-DD`
- `recordType`：记录类型，默认 `live`；可用值为 `live` 实盘、`replay` 复盘回放、`sim` 模拟盘、`hypothetical` 假设修正、`observation` 观察案例
- `entryTime` / `exitTime`：交易的北京时间（24 小时制，`HH:MM`）；跨北京时间午夜时仍填写实际发生的北京时间。网页会自动以 `date + entryTime` 换算 CME 交易日来关联 ATAS K 线
- `session`：美盘、欧盘、亚盘
- `dayPart`：早盘、午盘、尾盘
- `symbol`：NQ、MNQ、ES、MES
- `side`：Long 或 Short
- `strategy`：策略名称
- `entryLocation`：开单位置，如 VAH、VAL、POC、VWAP、LVP、前高/前低等；建议复用已有名称以保证统计一致
- `entry`：入场价，可留空
- `initialStop`：初始止损价，可留空
- `targetPrice`：计划目标价/止盈价，可留空
- `exit`：出场价，可留空
- `riskReward`：Risk/Reward，可留空，网页会在能计算时自动计算
- `realizedR`：实际 R，可留空，网页会用真实盈亏 / 初始风险美元自动计算
- `targetReached`：后续是否到目标，`true` 或 `false`；用于计算被保护或提前出场后错失的潜在利润
- `pnl`：手续费前美元盈亏；如果导入值已经是净盈亏，请将 `fees` 留空
- `fees`：手续费/佣金，填写正数，可留空
- `netPnl`：净盈亏，网页按 `pnl - fees` 自动计算；导入时可留空
- `qty`：合约数量
- `grade`：执行评分
- `exitReason`：出场原因，如到目标、保护止损、保本、锁盈、结构失效
- `managementTag`：交易管理标签，如按计划持有、推保护保本、推保护锁盈、过早保护
- `managementReview`：盘后保护评价，如合理保护、过早保护、过晚保护、未按计划
- `ruleBroken`：是否破规则，`true` 或 `false`，由人工手动标记
- `ruleViolation`：违规标签（可选）
- `emotionCause`：情绪原因
- `entrySignal`：入场信号（如 5m 收回 / 吸收反转 / 失败突破）
- `entryReason`：入场点位选择原因（结构 / 关键位 / 订单流依据）
- `notes`：通用备注，可记录任何补充内容、盘中观察或复盘想法

## K 线图与进出场标记

K 线图页面用来把每笔交易画到当天的行情上复盘。

1. 在交易日志或 CSV 里录入当天的交易（含入场/出场时间、入场/出场点位）。
2. 在 K 线图页面点「导入当日 K 线 (ATAS CSV)」，导入从 ATAS 导出的当日 K 线文件。
3. 网页只会列出“有交易记录 + 已导入 K 线”的日期；没有交易的日期不会显示 K 线图和订单轨迹。
4. 先选择年份/月，再选择当月交易日。当天交易会按进出场时间和点位自动画在 K 线上，进出场按顺序编号 ①②③；图下方按相同顺序列出每笔交易的策略、开单位置、入场信号、入场点位选择原因和备注。
5. 图表上方会显示该日期的手写每日总结；如果总览页尚未填写，则保持空白。

## 每日总结

总览页右侧月历和下方“每日总结 / 每日交易记录”联动：

1. 点击月历中的任意日期。
2. 下方“每日总结”和“每日交易记录”只切换到该日期，不跳转到交易日志。
3. 自己填写当天做得好/不好的地方、执行问题、情绪问题和明日改进。
4. 输入内容会自动保存，也可以点击「保存总结」手动保存。
5. 邮箱密码登录后，每日总结随 `user_settings` 云端同步；K 线图会读取同一份每日总结。

每日总结不会自动生成复盘文字，所有内容都以手写记录为准。

导入前先看 ATAS 图表当前横轴使用的时区：如果图表显示的是北京时间，选择“北京时间（与 ATAS 图一致）”；只有导出的时间确实是交易所时间时，才选择“CME / Chicago 时间”。网页会按这个选项保存和匹配，最终图表统一显示北京时间。

CSV 可以使用分号、逗号或 Tab 分隔，推荐保留表头。以下两类格式都支持：

```csv
Date;Time;Open;High;Low;Close;Volume
2026-07-15;09:30:00;22100.25;22104.50;22098.75;22103.50;120
```

```csv
2026-15-07 09:30:00;22100.25;22104.50;22098.75;22103.50
```

导入器会检查每一行是否满足 `High >= Open/Close/Low`、`Low <= Open/Close/High`。列错位或价格关系异常的数据会被跳过，不会写入本机或云端；导入结果会显示识别根数、时区和跳过行数。

K 线数据保存方式：

- 未登录时：保存在浏览器本机 IndexedDB（数据库 `trading-review-kline-db`）；旧版 `localStorage` K 线数据会自动迁移
- 邮箱密码登录后：同步到 Supabase 的 `kline_days` 表，其他设备登录同一邮箱后也能读取

导入文件可以包含无交易日期，这些数据会保留，但不会出现在 K 线日期导航中。以后补录该日交易后，对应 K 线会自动进入可复盘列表。

注意：交易 CSV 的 `date`、`entryTime` 和 `exitTime` 一律按北京时间填写和显示。K 线 CSV 的时间选项必须与 ATAS 导出文件本身一致；选错时区会让 K 线和进出场标记相差 12 至 13 小时。重新选择正确时区并上传同一天文件，会覆盖修正该交易日的旧 K 线。

## 缺失数据处理

默认筛选为 `实盘`，所以复盘回放、模拟盘、假设修正和观察案例会保存在同一套系统里，但不会默认进入实盘盈亏、胜率、资金曲线和回撤。需要混合查看时，在左侧 `记录类型` 筛选中选择 `全部类型` 或指定类型。

交易记录不需要字段完整才能保存。只填日期、品种、想法、备注或部分价格时，也会作为一条记录保留下来，并计入交易总笔数。
统计时按字段可用性分别计算：没有 `netPnl` 的记录不会进入胜率、Profit Factor、数学期望、资金曲线和回撤；没有 `points` 的记录不会进入点数统计；没有 `holdingMinutes` 或 `grade` 的记录不会进入对应平均值。
如果某些交易只有真实盈亏 `pnl`，没有 `entry`、`exit` 或 `initialStop`，网页不会报错，并且仍会进入净盈亏、胜率、Profit Factor、数学期望、最大回撤等需要盈亏的统计。
无法计算的点数、Risk/Reward 和 Realized R 会显示为 `-` 或保持空缺。Realized R 必须有 `initialStop`、`qty` 和可用净盈亏才会按初始风险计算。

旧交易没有 `entryLocation` 时仍可正常读取和统计其他指标，但不会进入开单位置统计；编辑旧交易并补填位置后会自动加入。

## 绩效指标口径

- `Total PnL`：手续费前盈亏总和。
- `Net PnL`：`Total PnL - Fees`，胜率、Profit Factor、回撤、图表与复盘均按它计算。
- `Gross Profit / Gross Loss`：手续费前盈利交易与亏损交易的合计。
- `Total Profit / Total Loss`：按净盈亏划分的盈利交易与亏损交易合计。
- `Max Drawdown Date`：交易级净值曲线发生最大金额回撤的日期。
- `Max Relative Drawdown`：最大相对回撤；必须先在设置中填写起始账户余额。
- `Recovery Factor`：`Net PnL / |Max Drawdown|`。
- `Daily PnL`：每个有交易日的平均净盈亏。
- `Sharpe Ratio`：日度净盈亏均值 / 日度样本标准差 × `sqrt(252)`；少于两个交易日显示 `-`。
- `Winning Days %`：盈利交易日数 / 总交易日数。
- `Win/Loss Ratio`：平均盈利 / 平均亏损。

## 数据保存

当前版本支持两种模式：

- 交易表单支持自动保存：输入或选择字段后会先保存为草稿/不完整记录，不必等所有字段填完再点保存
- 未登录：交易数据保存在当前浏览器的 `localStorage`
- 邮箱密码登录后：交易、策略手册、策略学习记录、设置、K 线数据会同步到 Supabase 云端数据库
- 每日总结保存在设置数据 `dailySummaries` 中；未登录时保存在本机，登录后随 `user_settings` 同步到云端
- 策略手册里的长文、关键词、入场规则、出场规则、失效条件和模型截图都会保存到 `strategy_manuals` 表；截图会先压缩，单个策略最多保留最近 12 张
- 起始账户余额保存在云端设置中；手续费和净盈亏字段保存在每笔交易的 JSON 数据中，不需要修改 Supabase 表结构

注意：

- 未登录时，换电脑或换浏览器不会自动同步
- 未登录时，清理浏览器缓存可能导致数据丢失
- 建议定期导出 CSV 备份

## Supabase 云端设置

1. 在 Supabase 创建项目
2. 打开 `SQL Editor`
3. 粘贴并运行 `supabase-schema.sql`
   - 如果之前已经运行过旧版本，也可以再次运行新版 SQL；它使用 `if not exists` 和 `drop policy if exists`，用于补齐新增的 `kline_days`、`strategy_learning_notes` 等表。
4. 打开 `Authentication` -> `URL Configuration`
5. Site URL 设置为：

```text
https://Eurekazzz111.github.io/trading-review-dashboard/
```

6. Redirect URLs 添加：

```text
https://Eurekazzz111.github.io/trading-review-dashboard/
```

7. 回到网页，输入邮箱，点击登录
8. 打开邮箱里的 Magic Link，回到网页后即可云端同步

不要把 Supabase `service_role` key 放到网页里。网页里只应该使用 publishable/anon key。

## GitHub Pages 部署

1. 创建一个新的 GitHub 仓库，例如 `trading-review-dashboard`
2. 上传 `index.html`、`README.md`、`trading-journal-simple-example.csv`
3. 打开仓库 `Settings` -> `Pages`
4. Source 选择 `Deploy from a branch`
5. Branch 选择 `main`，目录选择 `/root`
6. 保存后等待几分钟
7. 访问 `https://Eurekazzz111.github.io/trading-review-dashboard/`
