// LoginImageView.swift
import SwiftUI
struct LoginImageView: View {
    var body: some View {
        Image("AppIconImage")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 120)
            .padding(.vertical, 32)
    }
}

#Preview {
    LoginImageView()
}
