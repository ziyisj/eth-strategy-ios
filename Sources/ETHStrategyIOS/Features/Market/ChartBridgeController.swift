import Foundation
import WebKit

final class ChartBridgeController: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // 预留给后续 JS bridge：例如图表点击、策略切换、错误上报。
        print("Chart bridge message: \(message.name)")
    }
}
