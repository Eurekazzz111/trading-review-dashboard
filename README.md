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
- 风险管理记录：初始止损、目标价、出场原因、管理标签、保护评价、后续是否到目标
- 自动计算 Realized R、平均 Realized R、总 Realized R、盈亏比和目标错失利润
- NQ 默认每点 20 美元，MNQ 默认每点 2 美元，ES 默认每点 50 美元，MES 默认每点 5 美元
- Profit Factor、Win Rate、数学期望、Average Win / Average Loss（亏损统一显示为红色）
- 每日总记录、周统计、月历统计
- 累计盈亏曲线、每日盈亏柱状图
- K 线图：导入 ATAS 当日 K 线 CSV，支持 1m / 5m 切换和鼠标滚轮缩放；只显示同时存在交易记录和 K 线数据的交易日，按进出场时间和点位自动标注交易
- K 线历史按年份/月归档，每次只排列当月有交易的日期，适合持续记录数月或数年
- 按策略、盘段、方向、纪律执行统计
- 入场信号、入场点位选择原因记录；规则违规标签和情绪原因记录
- 破规则由人工手动标记（不再按执行评分自动推断），破规则理由写在备注里
- 策略手册支持手动维护关键词；左侧策略列表、右侧关键词复习和核心分析会同步显示，并保持同一关键词同一颜色
- 策略学习页：按大策略分类记录大段思考、反思、新知识和格外注意点，方便持续复习
- 策略手册关键词改为手动填写并同步显示；相同关键词在不同区域保持同色，方便复习
- 响应式布局，手机和平板可用；数据表数字右对齐、等宽对齐
- 策略手册、核心分析、AI 复盘提示
- Supabase 邮箱登录和云端同步

## 最近更新

- 策略手册关键词改为手动输入，不再从策略长文自动提炼；保存后会随策略手册一起同步。
- 同一个关键词在策略列表、关键词复习和核心分析中使用固定颜色，方便区分和复盘。
- 新增 `策略学习` 页面：按大策略分类记录大段思考、反思、新知识和格外注意点。
- 新增 `strategy_learning_notes` 云端表：邮箱登录后，策略学习记录可跨设备同步。
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

## CSV 格式

推荐字段：

```csv
id,date,entryTime,exitTime,session,dayPart,symbol,side,strategy,entry,initialStop,targetPrice,exit,riskReward,realizedR,targetReached,pnl,qty,grade,exitReason,managementTag,managementReview,ruleBroken,ruleViolation,emotionCause,entrySignal,entryReason,notes
```

示例：

```csv
T2001,2026-06-18,09:35,10:05,美盘,早盘,NQ,Long,Opening Drive,22000,21980,22050,22050,2.50,2.50,true,2000,2,5,到目标,按计划持有,无需评价,false,,,5m 收回开盘高点,前一日 VAH 上方回踩不破,按计划执行
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
- `targetPrice`：计划目标价/止盈价，可留空
- `exit`：出场价，可留空
- `riskReward`：Risk/Reward，可留空，网页会在能计算时自动计算
- `realizedR`：实际 R，可留空，网页会用真实盈亏 / 初始风险美元自动计算
- `targetReached`：后续是否到目标，`true` 或 `false`；用于计算被保护或提前出场后错失的潜在利润
- `pnl`：实际美元盈亏，可直接填写真实结果
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
- `notes`：备注；破规则时在此写明理由

## K 线图与进出场标记

K 线图页面用来把每笔交易画到当天的行情上复盘。

1. 在交易日志或 CSV 里录入当天的交易（含入场/出场时间、入场/出场点位）。
2. 在 K 线图页面点「导入当日 K 线 (ATAS CSV)」，导入从 ATAS 导出的当日 K 线文件。
3. 网页只会列出“有交易记录 + 已导入 K 线”的日期；没有交易的日期不会显示 K 线图和订单轨迹。
4. 先选择年份/月，再选择当月交易日。当天交易会按进出场时间和点位自动画在 K 线上，进出场按顺序编号 ①②③；图下方按相同顺序列出每笔交易的策略、入场信号、入场点位选择原因和备注。

ATAS 导出格式为 `年-日-月;开;高;低;收`（分号分隔，可含多天，无表头）。

K 线数据保存方式：

- 未登录时：保存在浏览器本机 IndexedDB（数据库 `trading-review-kline-db`）；旧版 `localStorage` K 线数据会自动迁移
- 邮箱登录后：同步到 Supabase 的 `kline_days` 表，其他设备登录同一邮箱后也能读取

导入文件可以包含无交易日期，这些数据会保留，但不会出现在 K 线日期导航中。以后补录该日交易后，对应 K 线会自动进入可复盘列表。

注意：K 线时间戳的时区必须和交易记录里的进出场时间一致（建议都用美东），否则标记会落在错误的 K 线上。

## 缺失数据处理

如果某些交易只有真实盈亏 `pnl`，没有 `entry`、`exit` 或 `initialStop`，网页不会报错。  
这类交易仍会参与总盈亏、Profit Factor、Win Rate、数学期望、最大回撤等统计。  
无法计算的点数、Risk/Reward 和 Realized R 会显示为 `-` 或保持空缺。Realized R 必须有 `initialStop` 和 `qty` 才能按初始风险计算。

## 数据保存

当前版本支持两种模式：

- 未登录：交易数据保存在当前浏览器的 `localStorage`
- 邮箱登录后：交易、策略手册、策略学习记录、设置、K 线数据会同步到 Supabase 云端数据库
- 策略手册里的长文、关键词、入场规则、出场规则和失效条件都会保存到 `strategy_manuals` 表

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
