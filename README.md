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
- `README.md`：项目说明。

## 当前功能

- 交易日志录入和 CSV 导入/导出
- 自动计算点数、美元盈亏、持仓时间、Risk/Reward
- NQ 默认每点 20 美元，MNQ 默认每点 2 美元，ES 默认每点 50 美元，MES 默认每点 5 美元
- Profit Factor、Win Rate、数学期望、Average Win / Average Loss
- 每日总记录、周统计、月历统计
- 累计盈亏曲线、每日盈亏柱状图
- 按策略、盘段、方向、纪律执行统计
- 规则违规标签和情绪原因记录
- 策略手册、核心分析、AI 复盘提示

## CSV 格式

推荐字段：

```csv
id,date,entryTime,exitTime,session,dayPart,symbol,side,strategy,entry,initialStop,exit,riskReward,pnl,qty,grade,ruleBroken,ruleViolation,emotionCause,notes
```

示例：

```csv
T2001,2026-06-18,09:35,10:05,美盘,早盘,NQ,Long,Opening Drive,22000,21980,22050,2.50,2000,2,5,false,,,大周期关键位上方回踩不破，按计划执行
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
- `ruleBroken`：是否破规则，`true` 或 `false`
- `ruleViolation`：违规标签
- `emotionCause`：情绪原因
- `notes`：备注

## 缺失数据处理

如果某些交易只有真实盈亏 `pnl`，没有 `entry`、`exit` 或 `initialStop`，网页不会报错。  
这类交易仍会参与总盈亏、Profit Factor、Win Rate、数学期望、最大回撤等统计。  
无法计算的点数和 Risk/Reward 会显示为 `-` 或保持空缺。

## 数据保存

当前版本是纯前端静态网页，交易数据保存在当前浏览器的 `localStorage`。

注意：

- 换电脑或换浏览器不会自动同步
- 清理浏览器缓存可能导致数据丢失
- 建议定期导出 CSV 备份
- 如果后续需要多设备同步，需要升级到数据库版本，例如 Supabase

## GitHub Pages 部署

1. 创建一个新的 GitHub 仓库，例如 `trading-review-dashboard`
2. 上传 `index.html`、`README.md`、`trading-journal-simple-example.csv`
3. 打开仓库 `Settings` -> `Pages`
4. Source 选择 `Deploy from a branch`
5. Branch 选择 `main`，目录选择 `/root`
6. 保存后等待几分钟
7. 访问 `https://Eurekazzz111.github.io/trading-review-dashboard/`

