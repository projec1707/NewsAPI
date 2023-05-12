// API key
// c7a2191be81c4eb4b41d7e9fb1ced092
//  NewsAPI
//
//  Created by Roman Riepa on 12.05.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataModel = DataModel()
    
    
    var body: some View {
        VStack {
            List(dataModel.articles) { article in
                VStack {
                    Text(article.title).fontWeight(.bold)
                    Text(article.descriptionText)
                }.padding(.vertical)
            }

        }
            .task {
                do {
                    try await dataModel.fetch()
                } catch let error as NetworkError {
                    print("Network error: \(error)")
                } catch {
                    print("Unexpected error: \(error)")
                }
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
