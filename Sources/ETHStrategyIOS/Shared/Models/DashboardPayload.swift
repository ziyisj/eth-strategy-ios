import Foundation

struct DashboardPayload: Codable {
    let snapshot: SignalSnapshot
    let candles: [CandleDTO]
    let indicators: IndicatorPayload
    let realtime: RealtimeDTO
    let meta: DashboardMeta
}

struct IndicatorPayload: Codable {
    let ma5: [Double?]
    let ma10: [Double?]
    let ma20: [Double?]
    let rsi14: [Double?]
    let macd: [Double?]
    let macdSignal: [Double?]
    let macdHistogram: [Double?]

    enum CodingKeys: String, CodingKey {
        case ma5, ma10, ma20, macd
        case rsi14
        case macdSignal = "macd_signal"
        case macdHistogram = "macd_histogram"
    }
}

struct SignalSnapshot: Codable {
    let recommendation: String
    let suggestedSide: String
    let suggestedEntry: Double
    let suggestedStopLoss: Double
    let suggestedTakeProfit: Double
    let marketRegime: String
    let marketBias: String
    let marketConfidence: Double
    let strategyDescription: String

    enum CodingKeys: String, CodingKey {
        case recommendation
        case suggestedSide = "suggested_side"
        case suggestedEntry = "suggested_entry"
        case suggestedStopLoss = "suggested_stop_loss"
        case suggestedTakeProfit = "suggested_take_profit"
        case marketRegime = "market_regime"
        case marketBias = "market_bias"
        case marketConfidence = "market_confidence"
        case strategyDescription = "strategy_description"
    }
}

struct DashboardMeta: Codable {
    let refreshSeconds: Int
    let instrument: String
    let bar: String
    let strategy: String
    let strategyLabel: String
    let strategyChoices: [StrategyChoice]?

    enum CodingKeys: String, CodingKey {
        case refreshSeconds = "refresh_seconds"
        case instrument
        case bar
        case strategy
        case strategyLabel = "strategy_label"
        case strategyChoices = "strategy_choices"
    }
}

struct StrategyChoice: Codable, Hashable {
    let name: String
    let label: String
}
