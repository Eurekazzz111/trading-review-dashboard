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

- 交易日志录入和 CSV 导入/导出
- 自动计算点数、美元盈亏、持仓时间、Risk/Reward
- NQ 默认每点 20 美元，MNQ 默认每点 2 美元，ES 默认每点 50 美元，MES 默认每点 5 美元
- Profit Factor、Win Rate、数学期望、Average Win / Average Loss（亏损统一显示为红色）
- 每日总记录、周统计、月历统计
- 累计盈亏曲线、每日盈亏柱状图
- K 线图：导入 ATAS 当日 K 线 CSV，按进出场时间和点位自动标注交易，进出场按顺序编号 ①②③，下方按顺序列出当日每笔交易（策略、入场信号、入场点位选择原因、备注）
- 按策略、盘段、方向、纪律执行统计
- 入场信号、入场点位选择原因记录；规则违规标签和情绪原因记录
- 破规则由人工手动标记（不再按执行评分自动推断），破规则理由写在备注里
- 策略学习页：按大策略分类记录大段思考、反思、新知识和格外注意点，方便持续复习
- 响应式布局，手机和平板可用；数据表数字右对齐、等宽对齐
- 策略手册、核心分析、AI 复盘提示
- Supabase 邮箱登录和云端同步

## CSV 格式

推荐字段：

```csv
id,date,entryTime,exitTime,session,dayPart,symbol,side,strategy,entry,initialStop,exit,riskReward,pnl,qty,grade,ruleBroken,ruleViolation,emotionCause,entrySignal,entryReason,notes
```

示例：

```csv
T2001,2026-06-18,09:35,10:05,美盘,早盘,NQ,Long,Opening Drive,22000,21980,22050,2.50,2000,2,5,false,,,5m 收回开盘高点,前一日 VAH 上方回踩不破,按计划执行
```

字段说明：

- `date`：交易日期，格式 `YYYY-MM-DD`
- `entryTime` / `exitTime`：入场和出场时间
- `session`：美盘、欧盘、亚盘
- `dayPart`：早盘、午盘、尾盘
- `symbol`：NQ、MNQ、ES、MES
- `side`：Long 或 Short
- `strategy`：策略名称
- `entry`：入场价，可留空
- `initialStop`：初始止损价，可留空
- `exit`：出场价，可留空
- `riskReward`：Risk/Reward，可留空，网页会在能计算时自动计算
- `pnl`：实际美元盈亏，可直接填写真实结果
- `qty`：合约数量
- `grade`：执行评分
- `ruleBroken`：是否破规则，`true` 或 `false`，由人工手动标记
- `ruleViolation`：违规标签（可选）
- `emotionCause`：情绪原因
- `entrySignal`：入场信号（如 5m 收回 / 吸收反转 / 失败突破）
- `entryReason`：入场点位选择原因（结构 / 关键位 / 订单流依据）
- `notes`：备注；破规则时在此写明理由

## K 线图与进出场标记

K 线图页面用来把每笔交易画到当天的行情上复盘。

1. 在交易日志或 CSV 里录入当天的交易（含入场/出场时间、入场/出场点位）。
2. 在 K 线图页面点「导入当日 K 线 (ATAS CSV)」，导入从 ATAS 导出的当日 K 线文件。
3. 选择日期后，当天的交易会按进出场时间和点位自动画在 K 线上，进出场按顺序编号 ①②③；图下方按相同顺序列出每笔交易的策略、入场信号、入场点位选择原因和备注。

ATAS 导出格式为 `年-日-月;开;高;低;收`（分号分隔，可含多天，无表头）。

K 线数据保存方式：

- 未登录时：保存在浏览器本机（`localStorage`，key 为 `trading-review-kline-v1`）
- 邮箱登录后：同步到 Supabase 的 `kline_days` 表，其他设备登录同一邮箱后也能读取

注意：K 线时间戳的时区必须和交易记录里的进出场时间一致（建议都用美东），否则标记会落在错误的 K 线上。

## 缺失数据处理

如果某些交易只有真实盈亏 `pnl`，没有 `entry`、`exit` 或 `initialStop`，网页不会报错。  
这类交易仍会参与总盈亏、Profit Factor、Win Rate、数学期望、最大回撤等统计。  
无法计算的点数和 Risk/Reward 会显示为 `-` 或保持空缺。

## 数据保存

当前版本支持两种模式：

- 未登录：交易数据保存在当前浏览器的 `localStorage`
- 邮箱登录后：交易、策略手册、策略学习记录、设置、K 线数据会同步到 Supabase 云端数据库

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
