//
//  HeaderView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.05.25.
//

import SwiftUI
// Header-Ansicht mit dem Button zum Hinzufügen eines neuen Supermarkts.
struct HeaderView: View {
    @Binding var showPopup: Bool
    var body: some View {
        HStack {
            Spacer()
                .padding()
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.green)
                .padding()
                .onTapGesture {
                    showPopup = true
                }
        }
        .padding(.trailing, 10)
    }
}
