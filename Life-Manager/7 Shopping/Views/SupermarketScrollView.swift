//
//  SupermarketScrollView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI
// Horizontale ScrollView für die Liste der Supermärkte.

struct SupermarketScrollView: View {
    @Binding var supermarket: [Supermarket]
    @Binding var selectedSupermarket: Supermarket?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(supermarket) { supermarket in
                    SupermarketButtonDetailView(supermarket: supermarket, selectedSupermarket: $selectedSupermarket)
                }
            }
        }
    }
}
