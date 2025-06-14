import SwiftUI
struct SupermarketDetailView: View {
    @ObservedObject var supermarket: Supermarket
    @State private var newItemName = ""
    @State private var struckThroughItem = Set<UUID>()
    var body: some View {
        let startColor = Color("BackgroundColor")
        let endColor = Color("SeColor")
        VStack {
            Text("Items for \(supermarket.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("New Item", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newItemName.isEmpty {
                        supermarket.items.append(Item(name: newItemName))
                        newItemName = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(newItemName.isEmpty)
            }
            .padding()
            List {
                ForEach(supermarket.items) { item in
                    HStack {
                        Image(systemName: struckThroughItem.contains(item.id) ? "checkmark.square" : "square")
                            .onTapGesture {
                                if struckThroughItem.contains(item.id) {
                                    struckThroughItem.remove(item.id)
                                } else {
                                    struckThroughItem.insert(item.id)
                                }
                            }
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(struckThroughItem.contains(item.id) ? .gray : .black) // Korrigierte Zeile
                            .strikethrough(struckThroughItem.contains(item.id), color: .red)
                    }
                }
                .onDelete { indexSet in
                    supermarket.items.remove(atOffsets: indexSet)
                }
            }
        }
        .background(
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
