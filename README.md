# ETH Strategy iOS App

这是 ETH 策略系统的 iOS 版本骨架。

## 首版目标

- 复用现有 `web-dashboard` 的 TradingView 风格图表体验
- 使用 `SwiftUI + WKWebView` 作为 iOS 原生外壳
- 对接现有 Python 聚合接口：
  - `/api/dashboard`
  - `/api/dashboard-stream`
- 首版优先支持 iPhone 竖屏
- 首版页面：行情、信号、设置

## 当前已建立内容

- `ETHStrategyIOS.xcodeproj`：可直接在 Xcode 打开的 iOS App 工程骨架
- `ETHStrategyIOS/App`：App 入口与配置
- `ETHStrategyIOS/Features/Market`：主行情页与图表容器
- `ETHStrategyIOS/Features/Signal`：信号卡片页
- `ETHStrategyIOS/Features/Settings`：设置页
- `ETHStrategyIOS/Networking`：接口模型与 APIClient
- `ETHStrategyIOS/Shared`：共享模型与 DashboardStore
- `.github/workflows/ios-build.yml`：GitHub Actions iOS 编译检查

## 推荐后续实现顺序

1. 新增 `web-dashboard/mobile/` 作为 iOS 专用轻量前端
2. 新增 `ChartBridgeController.swift` 做 Swift / JS 通信
3. 新增 `MarketViewModel.swift` 拉取 `/api/dashboard`
4. 创建真实 Xcode project 并在 iPhone 模拟器运行
5. 接入 SSE 或轮询刷新

## 首版路线

### 推荐
- SwiftUI 原生容器
- WKWebView 复用现有图表层
- 后端继续复用 Python OKX 数据与策略逻辑

### 不建议首版做
- 纯原生重写 K 线图
- 首版就做下单交易
- 首版就上 App Store 审核版本
