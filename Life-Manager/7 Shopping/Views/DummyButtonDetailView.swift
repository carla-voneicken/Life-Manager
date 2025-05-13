//
//  ShoppingButtonDetailView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 29.04.25.
import SwiftUI
// 1. Protokoll definieren:
protocol ButtonData: Identifiable {
    var id: UUID { get } // Jedes Element braucht eine ID
    var name: String { get }
    var color: Color { get }
}
// Extension, damit Supermarket das Protokoll erfüllt
extension Supermarket: ButtonData {}
//extens

import SwiftUI
struct GenericButtonDetailView<T: ButtonData>: View { // Generic-Typ "T" mit der Bedingung das "T" ButtonData ist
    let data: T // T kann nun Supermarket oder Mission sein
    @Binding var selectedData: T? // Selbes Prinzip wie oben
    
    var body: some View {
        Button {
            if selectedData?.id == data.id { // Überprüfe, ob der Button bereits ausgewählt ist
                selectedData = nil // Auswahl zurücksetzen
            } else {
                selectedData = data // Button auswählen
            }
        } label: {
            Text(data.name)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 150, height: 150)
                .background(data.color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(10)
        }
    }
}


import SwiftUI
struct DummyButtonDetailView: View {
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

struct DummyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        // Erstelle eine Beispielmission mit einer Farbe
        let exampleSupermarket = Supermarket(name: "Test Supermarket")
        exampleSupermarket.color = .orange
        
        @State var selectedSupermarket: Supermarket? = nil
        
        return DummyButtonDetailView(supermarket: exampleSupermarket, selectedSupermarket: $selectedSupermarket)
            .previewLayout(.sizeThatFits)
    }
}

