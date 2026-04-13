import SwiftUI

struct MarketView: View {
    @EnvironmentObject private var config: AppConfig

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            TradingChartWebView(url: chartURL)
                .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("ETH策略系统")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.black)
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
            Text("ETH-USDT-SWAP")
                .font(.headline)
                .foregroundStyle(.white)
            HStack(spacing: 12) {
                Label(config.defaultBar, systemImage: "chart.xyaxis.line")
                Label(config.defaultStrategy, systemImage: "brain")
                Label("iOS 首版骨架", systemImage: "iphone")
            }
            .font(.caption)
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
    }
}
