

import Foundation
import SwiftUI

enum NetworkErrorQ: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case requestError
    case decodingError

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .httpError(let statusCode):
            return "HTTP error: status code \(statusCode)"
        case .requestError:
            return "Request error"
        case .decodingError:
            return "Decoding error"
        }
    }
}
@MainActor
class UserViewModel: ObservableObject {
    @Published var artic: [Article] = []
    @Published var error: Error?

    func fetchUsers() async throws {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-04-12&sortBy=publishedAt&apiKey=c7a2191be81c4eb4b41d7e9fb1ced092") else {
            throw NetworkErrorQ.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse

            guard httpResponse?.statusCode == 200 else {
                let statusCode = httpResponse?.statusCode ?? 0
                throw NetworkErrorQ.httpError(statusCode: statusCode)
            }

            do {
                let decodedData = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
                artic = decodedData.articles
            } catch {
                throw NetworkErrorQ.decodingError
            }
        } catch {
            throw NetworkErrorQ.requestError
        }
    }
}
