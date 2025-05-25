//
//  SupermarketDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI

struct  SupermarketDetailView: View {
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
                        supermarket.items.append(Item(name: newItemName, isCompleted: true))
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
                        Image(systemName: item.isCompleted ? "square" : "checkmark.square.fill")
                            .onTapGesture {
                                item.isCompleted.toggle()
                            }
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
        .background(  // Hier wird der Hintergrund hinzugefügt
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)  
        )
    }
}

