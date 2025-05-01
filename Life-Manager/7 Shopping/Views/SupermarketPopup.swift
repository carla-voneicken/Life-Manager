//
//  SupermarketPopup.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI
// Popup-Fenster zum Hinzufügen eines neuen Supermarkts.

struct SupermarketPopup: View {
    @Binding var showPopup: Bool
    @Binding var newSupermarketTitle: String
    var addNewSupermarket: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            Text("New Supermarket")
                .font(.headline)
                .padding()
            TextField("Name", text: $newSupermarketTitle)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            HStack {
                Button("Add") {
                    addNewSupermarket()
                }
                .buttonStyle(PopupButtonStyle())
                Button("Cancel") {
                    withAnimation {
                        showPopup = false
                    }
                }
                .buttonStyle(PopupButtonStyle(isCancel: true))
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.pink.opacity(0.3))
        .cornerRadius(10)
        .padding()
        .transition(.scale)
    }
}
