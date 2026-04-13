import Combine
import Foundation

final class AppConfig: ObservableObject {
    @Published var baseURLString: String = "http://127.0.0.1:8765"
    @Published var defaultInstrument: String = "ETH-USDT-SWAP"
    @Published var defaultBar: String = "15m"
    @Published var defaultStrategy: String = "okx_15m_mtf"

    let availableBars: [String] = ["1m", "5m", "15m", "1H"]
    let availableStrategies: [String] = ["okx_15m_mtf", "macd", "okx_15m_intraday"]

    var baseURL: URL {
        URL(string: baseURLString) ?? URL(string: "http://127.0.0.1:8765")!
    }
}
