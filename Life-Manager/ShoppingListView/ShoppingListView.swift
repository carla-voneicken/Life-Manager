import SwiftUI
class Supermarket: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String
    @Published var items: [ShoppingItem] = []
    init(name: String) {
        self.name = name
    }
}
struct ShoppingItem: Identifiable {
    let id = UUID()
    var name: String
}
struct ShoppingListView: View {
  
    @State private var supermarkets: [Supermarket] = [
        Supermarket(name: "Edeka"),
        Supermarket(name: "Aldi"),
        Supermarket(name: "Lidl"),
        Supermarket(name: "Rewe")
    ]
    @State private var showingAddSupermarket = false
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(supermarkets, id: \.id) { supermarket in
                        NavigationLink {
                            SupermarketDetailView(supermarket: supermarket)
                        } label: {
                            Text(supermarket.name)
                        }
                    }
                    .onDelete(perform: deleteSupermarket)
                }
                .listStyle(.plain)
                Button("Supermarkt hinzufügen") {
                    showingAddSupermarket = true
                }
                .padding()
            }
            .navigationTitle("Einkaufsliste")
            .sheet(isPresented: $showingAddSupermarket) {
                AddSupermarketView(supermarkets: $supermarkets, isPresented: $showingAddSupermarket)
            }
        }
    }
    func deleteSupermarket(at offsets: IndexSet) {
        supermarkets.remove(atOffsets: offsets)
    }
}
struct AddSupermarketView: View {
    @Binding var supermarkets: [Supermarket]
    @State private var newSupermarketName = ""
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView {
            Form {
                TextField("Supermarkt Name", text: $newSupermarketName)
                Button("Hinzufügen") {
                    if !newSupermarketName.isEmpty {
                        supermarkets.append(Supermarket(name: newSupermarketName))
                        isPresented = false
                    }
                }
                .disabled(newSupermarketName.isEmpty)
            }
            .navigationTitle("Neuer Supermarkt")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
struct SupermarketDetailView: View {
    @ObservedObject var supermarket: Supermarket
    @State  var newItemName = ""
    @State  var struckThroughItems2 = Set<UUID>()
    var body: some View {
        VStack {
            Text("Artikel für \(supermarket.name)")
                .font(.title)
                .padding()
            HStack {
                TextField("Neues Item", text: $newItemName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    if !newItemName.isEmpty {
                        supermarket.items.append(ShoppingItem(name: newItemName))
                        newItemName = ""
                    }
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(newItemName.isEmpty)
            }
            .padding()
            List {
                ForEach(supermarket.items, id: \.id) { item in
                    HStack {
                        Text(item.name)
                            .strikethrough(struckThroughItems2.contains(item.id), color: .red)
                            .onTapGesture {
                                if struckThroughItems2.contains(item.id) {
                                    struckThroughItems2.remove(item.id)
                                } else {
                                    struckThroughItems2.insert(item.id)
                                }
                            }
                    }
                }
                .onDelete { indexSet in
                    supermarket.items.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle(supermarket.name)
    }
}
#Preview {
    ShoppingListView()
       
}
