//
//  SupermarketItemDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 25.05.25.
/*
import SwiftUI

struct SupermarketItemDetailView: View {
    @Binding var item: Item
    
    var body: some View {
        HStack {
            // Image of square (can be "checked")
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    item.isCompleted.toggle()
                }
                .padding(.trailing)
            VStack (alignment: .leading){
                // Title
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .gray : .black)
                    .strikethrough(item.isCompleted ? true : false)
                // Description
                if item.description != nil {
                    Text(item.description!)
                        .font(.caption2)
                        .foregroundColor(item.isCompleted ? .gray : .black)
                        .strikethrough(item.isCompleted ? true : false)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    @Previewable @State var item: Item = Item(
        title: "Erdbeeren",
        isCompleted: false
    )
    SupermarketItemDetailView(item: $item)
}
*/
