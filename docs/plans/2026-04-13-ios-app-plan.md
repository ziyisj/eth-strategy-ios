# ETH iOS App Implementation Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** 为当前 ETH 策略系统新增一个同款风格的 iOS App，首版优先复用现有 TradingView 风格图表与 OKX 实时数据能力。

**Architecture:** 采用 `SwiftUI + WKWebView` 作为 iOS 原生外壳，复用现有 `web-dashboard` 图表层；后端继续由 Python 负责 OKX 实时行情、指标、信号与聚合 payload。首版不重写原生 K 线引擎，优先做可运行的 iPhone App 骨架。

**Tech Stack:** SwiftUI, WebKit, URLSession, Codable, Python dashboard API, lightweight-charts

---

## Task 1: 创建 iOS App 目录与文档骨架

**Objective:** 在仓库中建立 `ios-app/` 结构，并写明首版目标与接入方式。

**Files:**
- Create: `ios-app/README.md`
- Create: `docs/plans/2026-04-13-ios-app-plan.md`

**Verification:**
- `ios-app/README.md` 存在
- 文档中明确说明首版路线：SwiftUI + WKWebView

## Task 2: 创建 SwiftUI App 基础结构

**Objective:** 建立可扩展的 iOS 工程源码目录，包含 App 入口、配置、主行情页。

**Files:**
- Create: `ios-app/ETHStrategyIOS/App/ETHStrategyApp.swift`
- Create: `ios-app/ETHStrategyIOS/App/AppConfig.swift`
- Create: `ios-app/ETHStrategyIOS/Features/Market/MarketView.swift`
- Create: `ios-app/ETHStrategyIOS/Features/Market/TradingChartWebView.swift`

**Verification:**
- 目录结构完整
- Swift 文件命名清晰，已包含首版页面骨架

## Task 3: 定义移动端数据模型

**Objective:** 为 `/api/dashboard` 聚合响应建立 iOS 侧 Codable 模型。

**Files:**
- Create: `ios-app/ETHStrategyIOS/Networking/DTOs.swift`
- Create: `ios-app/ETHStrategyIOS/Shared/Models/DashboardPayload.swift`

**Verification:**
- 模型覆盖 `candles` / `indicators` / `snapshot` / `realtime` / `meta`

## Task 4: 接入首版原生容器

**Objective:** 让 SwiftUI 页面能加载本地/远端 dashboard 页面，并预留 JS bridge。

**Files:**
- Modify: `ios-app/ETHStrategyIOS/Features/Market/TradingChartWebView.swift`
- Create: `ios-app/ETHStrategyIOS/Features/Market/ChartBridgeController.swift`

**Verification:**
- `TradingChartWebView` 已具备加载 URL 与 bridge 预留能力

## Task 5: 补充后端/前端移动适配说明

**Objective:** 明确下一步需要新增的 mobile dashboard 入口和 API 契约。

**Files:**
- Modify: `ios-app/README.md`
- Optional next: `web-dashboard/mobile/*`
- Optional next: `src/eth_backtester/mobile_api/*`

**Verification:**
- README 中写清楚后续待接：
  - `/api/dashboard`
  - `/api/dashboard-stream`
  - `web-dashboard/mobile/`

## First Milestone Deliverable

首版里程碑不是 App Store 成品，而是：
1. 仓库内有完整 iOS 目录骨架
2. 有 SwiftUI 主页面与 WebView 容器
3. 有移动端数据模型
4. 有后续接入说明

## Next Milestone

下一阶段直接继续做：
1. 新增 `web-dashboard/mobile/` 页面
2. 新增 `ChartBridgeController.swift`
3. 新增 `MarketViewModel.swift` + `URLSession` 拉取 `/api/dashboard`
4. 建立真实 Xcode project 并打包运行
