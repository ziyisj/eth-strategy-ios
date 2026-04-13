import Combine
import Foundation

@MainActor
final class DashboardStore: ObservableObject {
    @Published var payload: DashboardPayload?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdatedAt: Date?

    private let client = APIClient()
    private var refreshTask: Task<Void, Never>?

    func refresh(using config: AppConfig) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let data = try await client.fetchDashboard(
                baseURL: config.baseURL,
                bar: config.defaultBar,
                strategy: config.defaultStrategy
            )
            payload = data
            errorMessage = nil
            lastUpdatedAt = Date()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func startAutoRefresh(using config: AppConfig) {
        stopAutoRefresh()
        refreshTask = Task {
            while !Task.isCancelled {
                await refresh(using: config)
                try? await Task.sleep(nanoseconds: 5_000_000_000)
            }
        }
    }

    func stopAutoRefresh() {
        refreshTask?.cancel()
        refreshTask = nil
    }
}
