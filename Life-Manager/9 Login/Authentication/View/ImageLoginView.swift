// LoginImageView.swift
import SwiftUI
struct LoginImageView: View {
    var body: some View {
        Image("AppIconImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 150)
          
            .padding(.vertical, 32)
    }
}

#Preview {
    LoginImageView()
}
