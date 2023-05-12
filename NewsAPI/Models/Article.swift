

import Foundation


struct Article {
    
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
 //   let publishedAt: Date
    let content: String
    
    var autorText: String {
        author ?? ""
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var articleURL: URL {
        URL(string: url)!
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
    static let example = Article(
        source: Source(name: "Biztoc.com"),
        author: "investing.com",
        title: "Wall St opens higher on gains in Tesla, hopes of rate-hike pause",
        description: "Wall Street's main stock indexes opened higher on Friday as Tesla (NASDAQ: ) shares rose and regional banks held steady after a selloff, while hopes of a pause in interest rate hikes bolstered investor sentiment. The rose 61.07 points, or 0.18%, at the open t…",
        url: "https://biztoc.com/x/c708fd844151ef62",
        urlToImage: "https://c.biztoc.com/p/c708fd844151ef62/og.webp",
      //  publishedAt: Date(),
        content: "Wall Street's main stock indexes opened higher on Friday as Tesla (NASDAQ: ) shares rose and regional banks held steady after a selloff, while hopes of a pause in interest rate hikes bolstered invest…")
}

extension Article: Codable, Equatable {}
extension Article: Identifiable {
    var id: String { url }
}


struct Source: Codable, Equatable {
    let name: String
}
