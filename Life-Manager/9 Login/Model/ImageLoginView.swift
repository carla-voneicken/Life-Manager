// LoginImageView.swift
import SwiftUI
struct LoginImageView: View {
    var body: some View {
        Image(systemName: "person.2.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 120)
            .padding(.vertical, 32)
    }
}
