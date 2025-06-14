
import SwiftUI

struct GenericPopupView: View {
    @Binding var showPopup: Bool
    @Binding var titleText: String
    @Binding var textFieldText: String
    var confirmAction: () -> Void
    var cancelAction: () -> Void
    let popupTitle: String
    let textFieldPlaceholder: String
    var body: some View {
        VStack(spacing: 20) {
            Text(popupTitle)
                .font(.headline)
                .padding()
            TextField(textFieldPlaceholder, text: $textFieldText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            HStack {
                Button("Confirm") {
                    confirmAction()
                }
                .buttonStyle(PopupButtonStyle())
                Button("Cancel") {
                    cancelAction()
                    withAnimation {
                        showPopup = false
                    }
                }
                .buttonStyle(PopupButtonStyle(isCancel: true))
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.popup)
        .cornerRadius(10)
        .padding()
        .transition(.scale)
    }
}
struct PopupButtonStyle: ButtonStyle {
    var isCancel: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isCancel ? Color.red.opacity(0.7) : Color.blue.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}


