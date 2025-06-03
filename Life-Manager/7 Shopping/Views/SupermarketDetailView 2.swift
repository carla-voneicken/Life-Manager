//
//  SupermarketDetailView 2.swift
//  Life-Manager
//
//  Created by Christiane Roth on 03.06.25.
//

/*
import SwiftUI
struct SupermarketDetailView: View {
    @ObservedObject var supermarket: Supermarket
    @State private var newItemName = ""
    @State private var struckThroughItem = Set<UUID>()
    var body: some View {
        let startColor = Color("BackgroundColor")
        let endColor = Color("SeColor")
        VStack {
            Text("Items for \(supermarket.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("New Item", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newItemName.isEmpty {
                        supermarket.items.append(Item(name: newItemName, isCompleted: false))
                        newItemName = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(newItemName.isEmpty)
            }
            .padding()
            List {
                ForEach(supermarket.items) { item in
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                            .onTapGesture {
                                item.isCompleted.toggle()
                            }
                        Text(item.name)
                            .strikethrough(item.isCompleted, color: .red)
                    }
                }
                .onDelete { indexSet in
                    supermarket.items.remove(atOffsets: indexSet)
                }
            }
        }
        .background(
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
*/
