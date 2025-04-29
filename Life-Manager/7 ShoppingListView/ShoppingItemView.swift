
import SwiftUI
struct ShoppingItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    @State var description: String? = nil
    var isCompleted: Bool = false
}
struct ShoppingItemView: View {
    @Binding var item: ShoppingItem
    var body: some View {
        HStack {
            // Image of square (can be "checked")
            Image(systemName: item.isCompleted ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    item.isCompleted.toggle()
                }
                .padding(.trailing)
            VStack(alignment: .leading) {
                // Title
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(item.isCompleted ? .gray : .black)
                    .strikethrough(item.isCompleted ? true : false)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
struct ShoppingItemView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleItem = ShoppingItem(title: "Test Item", isCompleted: false)
        @State var item = exampleItem
        return ShoppingItemView(item: $item)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
