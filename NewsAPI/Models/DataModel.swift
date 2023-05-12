

import Foundation
import SwiftUI

enum NetworkError: Error, Identifiable {
    var id: String { localizedDescription }
    
    case urlError
    case decodeError
    case networkRequestFailed
    case unknown
    
//    var localizedDescription: String {
//        switch self {
//        case .urlError:
//            return "Invalid URL"
//        case .decodeError:
//            return "HTTP error: status code \(statusCode)"
//        case .networkRequestFailed:
//            return "Request error"
//        case .unknown:
//            return "Decoding error"
//        }
//    }
}

@MainActor
class DataModel: ObservableObject {
    
    @Published var articles: [Article] = []
    
    private let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-04-12&sortBy=publishedAt&apiKey=c7a2191be81c4eb4b41d7e9fb1ced092" 
    
    func fetch() async throws {
        guard let url = URL(string: urlString) else {
            throw NetworkError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse?.statusCode)

        guard httpResponse?.statusCode == 200 else {
            let statusCode = httpResponse?.statusCode ?? 0
            throw NetworkErrorQ.httpError(statusCode: statusCode)
        }
        
        
//        guard let httpResponse = response as? HTTPURLResponse,
//                httpResponse.statusCode == 200 else {
//            throw NetworkError.networkRequestFailed
//        }
        
        let newsAPIResponse = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        articles = newsAPIResponse.articles
    }
}
