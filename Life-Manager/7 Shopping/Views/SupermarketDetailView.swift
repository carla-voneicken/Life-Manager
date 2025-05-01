//
//  SupermarketDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI

struct SupermarketDetailView: View {
    @ObservedObject var supermarket: Supermarket
    @State private var newItemName = ""
    @State private var struckThroughItem = Set<UUID>()
    var body: some View {
        VStack {
            Text("Items for \(supermarket.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("New Item", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newItemName.isEmpty {
                        supermarket.items.append(Item(name: newItemName))
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
                        Text(item.name)
                            .strikethrough(struckThroughItem.contains(item.id), color: .red)
                            .onTapGesture {
                                if struckThroughItem.contains(item.id) {
                                    struckThroughItem.remove(item.id)
                                } else {
                                    struckThroughItem.insert(item.id)
                                }
                            }
                    }
                }
                .onDelete { indexSet in
                    supermarket.items.remove(atOffsets: indexSet)
                }
            }
        }
    }
}
