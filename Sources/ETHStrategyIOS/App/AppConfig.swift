import Foundation

final class AppConfig: ObservableObject {
    @Published var baseURL: URL = URL(string: "http://127.0.0.1:8765")!
    @Published var defaultInstrument: String = "ETH-USDT-SWAP"
    @Published var defaultBar: String = "15m"
    @Published var defaultStrategy: String = "okx_15m_mtf"
}
