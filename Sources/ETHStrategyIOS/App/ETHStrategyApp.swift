import SwiftUI

@main
struct ETHStrategyApp: App {
    @StateObject private var config = AppConfig()
    @StateObject private var store = DashboardStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(config)
                .environmentObject(store)
        }
    }
}
