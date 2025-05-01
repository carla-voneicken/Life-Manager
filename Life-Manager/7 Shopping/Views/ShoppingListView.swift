//
//  ShoppingListView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI
// Hauptansicht

struct ShoppingListView: View {
    @State private var newSupermarketTitle: String = ""
    @State private var supermarket: [Supermarket] = [
        Supermarket(name: "Aldi", color: .red),
        Supermarket(name: "Edeka", color: .yellow),
        Supermarket(name: "Ikea", color: .purple),
        Supermarket(name: "Bauhaus", color: .mint)
    ]
    @State private var selectedSupermarket: Supermarket?
    @State private var showPopup: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(showPopup: $showPopup)
                SupermarketScrollView(supermarket: $supermarket, selectedSupermarket: $selectedSupermarket)
                if let selectedSupermarket = selectedSupermarket {
                    SupermarketDetailView(supermarket: selectedSupermarket)
                }
                Spacer()
            }
            .overlay(
                Group {
                    if showPopup {
                        SupermarketPopup(showPopup: $showPopup, newSupermarketTitle: $newSupermarketTitle, addNewSupermarket: addNewSupermarket)
                            .transition(.scale)
                    }
                }
            )
        }
    }
 // neuer Supermarkt der hinzu gefügt wird
    
    private func addNewSupermarket() {
        if !newSupermarketTitle.isEmpty {
            let newSupermarket = Supermarket(name: newSupermarketTitle, color: Color.random())
            supermarket.append(newSupermarket)
            newSupermarketTitle = ""
        }
        showPopup = false
    }
}
#Preview {
    ShoppingListView()
}
