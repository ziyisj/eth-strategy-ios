import SwiftUI

@main
struct ETHStrategyApp: App {
    @StateObject private var config = AppConfig()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MarketView()
                    .environmentObject(config)
            }
        }
    }
}
