//
//  ShoppingButtonDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 29.04.25.
//

import SwiftUI
struct SupermarketButtonDetailView: View {
    let supermarket: Supermarket
    // Binding, damit Änderungen hier die Hauptansicht beeinflussen.
    @Binding var selectedSupermarket: Supermarket?
    
    var body: some View {
        Button {
            selectedSupermarket = supermarket
        } label: {
            Text(supermarket.name)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 150, height: 150)
                .background(supermarket.color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(10)
        }
    }
}

struct SupermarketButtonView_Previews: PreviewProvider {
    static var previews: some View {
        // Erstelle eine Beispielmission mit einer Farbe
        let exampleSupermarket = Supermarket(name: "Test Supermarket")
        exampleSupermarket.color = .orange
        
        @State var selectedSupermarket: Supermarket? = nil
        
        return SupermarketButtonDetailView(supermarket: exampleSupermarket, selectedSupermarket: $selectedSupermarket)
            .previewLayout(.sizeThatFits)
    }
}

