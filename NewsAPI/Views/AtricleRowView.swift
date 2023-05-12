

import SwiftUI

struct AtricleRowView: View {
    
    @ObservedObject var model: DataModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AtricleRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AtricleRowView(model: DataModel())
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
    }
}
