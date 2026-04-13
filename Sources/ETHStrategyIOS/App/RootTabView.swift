import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                MarketView()
            }
            .tabItem {
                Label("行情", systemImage: "chart.line.uptrend.xyaxis")
            }

            NavigationStack {
                SignalView()
            }
            .tabItem {
                Label("信号", systemImage: "bolt.horizontal.circle")
            }

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("设置", systemImage: "gearshape")
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RootTabView()
        .environmentObject(AppConfig())
        .environmentObject(DashboardStore())
}
