import Foundation
import SwiftUI

struct SignalView: View {
    @EnvironmentObject private var store: DashboardStore

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                metricCard(title: "当前建议", value: recommendationText)
                metricCard(title: "建议方向", value: store.payload?.snapshot.suggestedSide ?? "-")
                metricCard(title: "建议开仓", value: formatted(store.payload?.snapshot.suggestedEntry))
                metricCard(title: "止损", value: formatted(store.payload?.snapshot.suggestedStopLoss))
                metricCard(title: "止盈", value: formatted(store.payload?.snapshot.suggestedTakeProfit))
                metricCard(title: "市场状态", value: store.payload.map { "\($0.snapshot.marketRegime) / \($0.snapshot.marketBias)" } ?? "-")

                VStack(alignment: .leading, spacing: 8) {
                    Text("策略说明")
                        .font(.headline)
                        .foregroundStyle(.white)
                    Text(store.payload?.snapshot.strategyDescription ?? "等待策略说明")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(red: 15/255, green: 23/255, blue: 42/255))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .background(Color.black)
        .navigationTitle("信号")
    }

    private var recommendationText: String {
        switch store.payload?.snapshot.recommendation {
        case "enter_long": return "建议开多"
        case "exit_long": return "建议平仓"
        case "hold_long": return "继续持有"
        case "stand_aside": return "继续观望"
        default: return "等待数据"
        }
    }

    private func formatted(_ value: Double?) -> String {
        guard let value else { return "-" }
        return String(format: "%.2f USDT", value)
    }

    private func metricCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 15/255, green: 23/255, blue: 42/255))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
