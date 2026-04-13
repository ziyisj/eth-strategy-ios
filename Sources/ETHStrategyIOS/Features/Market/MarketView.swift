import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var config: AppConfig
    @EnvironmentObject private var store: DashboardStore

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            TradingChartWebView(url: chartURL)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            footer
        }
        .navigationTitle("ETH策略系统")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black)
        .task {
            if store.payload == nil {
                await store.refresh(using: config)
            }
            store.startAutoRefresh(using: config)
        }
        .onDisappear {
            store.stopAutoRefresh()
        }
        .refreshable {
            await store.refresh(using: config)
        }
    }

    private var chartURL: URL {
        var components = URLComponents(url: config.baseURL, resolvingAgainstBaseURL: false)!
        components.path = "/"
        components.queryItems = [
            URLQueryItem(name: "bar", value: config.defaultBar),
            URLQueryItem(name: "strategy", value: config.defaultStrategy),
        ]
        return components.url ?? config.baseURL
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(store.payload?.meta.instrument ?? config.defaultInstrument)
                .font(.headline)
                .foregroundStyle(.white)
            HStack(spacing: 12) {
                Label(store.payload?.meta.bar ?? config.defaultBar, systemImage: "chart.xyaxis.line")
                Label(store.payload?.meta.strategyLabel ?? config.defaultStrategy, systemImage: "brain")
                Label(store.payload?.realtime.status ?? "未连接", systemImage: "dot.radiowaves.left.and.right")
            }
            .font(.caption)
            .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 10/255, green: 15/255, blue: 26/255))
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(store.errorMessage ?? "已连接到仪表盘接口")
                .font(.caption)
                .foregroundStyle(store.errorMessage == nil ? .gray : .red)
            Text(store.lastUpdatedAt.map { "上次刷新：\($0.formatted(date: .omitted, time: .standard))" } ?? "等待首次同步")
                .font(.caption2)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(red: 10/255, green: 15/255, blue: 26/255))
    }
}

#Preview {
    NavigationStack {
        MarketView()
            .environmentObject(AppConfig())
            .environmentObject(DashboardStore())
    }
}
