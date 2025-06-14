// Item.swift
import SwiftUI
class Item: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var isCompleted: Bool = false
    @Published var description: String? // Hinzugefügt: Optionales Beschreibungsfeld
    init(name: String, isCompleted: Bool = false, description: String? = nil) { // Beschreibungsfeld initialisieren
        self.name = name
        self.isCompleted = isCompleted
        self.description = description
    }
    
    static var sampleItems: [Item] = [
        Item(
            name: "Erdbeeren",
            isCompleted: true,
            description: "Frische, rote Erdbeeren"
        ),
        Item(
            name: "Milch",
            isCompleted: true,
            description: "3.5% Fett"
        ),
        Item(
            name: "Brot",
            isCompleted: true,
            description: "Vollkorn"
        )
    ]
}

struct ItemListView: View {
    let items: [Item]
    var body: some View {
        List(items) { item in
            HStack {
                Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                    .onTapGesture { item.isCompleted.toggle() }
                Text(item.name)
                    .foregroundColor(item.isCompleted ? .gray : .black)
                    .strikethrough(item.isCompleted ? true : false)
                if let description = item.description { // Optionales Binding verwenden
                    Text(description)
                        .font(.caption2)
                        .foregroundColor(item.isCompleted ? .gray : .black)
                        .strikethrough(item.isCompleted ? true : false)
                }
                Spacer()
            }
        }
    }
}
#Preview {
    ItemListView(items: Item.sampleItems) // Preview benötigt jetzt ein Array von Items
}
