//
import SwiftUI
struct LoginImage: View {
    var body: some View {
        Image("AppIconImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 150)
          
            .padding(.vertical, 32)
    }
}

#Preview {
    LoginImage()
}
