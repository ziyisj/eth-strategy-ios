import Foundation

struct APIClient {
    func fetchDashboard(baseURL: URL, bar: String, strategy: String) async throws -> DashboardPayload {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) ?? URLComponents()
        components.path = "/api/dashboard"
        components.queryItems = [
            URLQueryItem(name: "bar", value: bar),
            URLQueryItem(name: "strategy", value: strategy),
        ]

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        let decoder = JSONDecoder()
        do {
            return try decoder.decode(DashboardPayload.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
