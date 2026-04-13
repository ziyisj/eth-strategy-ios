import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "接口地址无效"
        case .invalidResponse:
            return "服务器返回了无效响应"
        case .decodingFailed(let error):
            return "数据解析失败：\(error.localizedDescription)"
        }
    }
}

struct CandleDTO: Codable, Hashable {
    let time: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Double
}

struct RealtimeDTO: Codable, Hashable {
    let latestPrice: Double?
    let latestPriceTs: String?
    let latestCandleClose: Double?
    let status: String
    let lastError: String?
    let transport: String?

    enum CodingKeys: String, CodingKey {
        case latestPrice = "latest_price"
        case latestPriceTs = "latest_price_ts"
        case latestCandleClose = "latest_candle_close"
        case status
        case lastError = "last_error"
        case transport
    }
}
