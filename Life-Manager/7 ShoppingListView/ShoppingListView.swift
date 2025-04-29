//
//  TaskView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 29.04.25.
//

import SwiftUI
struct Item: Identifiable {
    let id = UUID()
    var name: String
}
class Supermarket: Identifiable, ObservableObject, Equatable { // Wichtig um zu erkennen wo welcher String hingeschrieben wird. Ob lhs und rhs gleich sind oder nicht
    let id = UUID()
    @Published var name: String
    @Published var items: [Item] = []
    @Published var color: Color  // Füge eine Farbe hinzu
       init(name: String, color: Color = .blue) {  // Standardfarbe ist Blau
           self.name = name
           self.color = color
    }
    
    // Equatable-Konformität - vergleicht die verschiedenen Id´s
    static func == (lhs: Supermarket, rhs: Supermarket) -> Bool {
        return lhs.id == rhs.id
    }
}
struct ShoppingListView: View {
    @State private var newSupermarketTitle: String = ""
    @State private var supermarket: [Supermarket] = [
        Supermarket(name: "Aldi", color: .red),
        Supermarket(name: "Edeka", color: .yellow),
        Supermarket(name: "Ikea", color: .purple),
        Supermarket(name: "Bauhaus", color: .mint)
    ]
    @State private var selectedSupermarket: Supermarket?
    @State private var showPopup: Bool = false
    
//  Hintergrundfarbe bei Auswahl
    private func backgroundColor(for supermarket: Supermarket) -> Color {
        if let selected = selectedSupermarket {
            return selected == supermarket ? Color.green.opacity(0.5) : Color.blue.opacity(0.2)
        } else {
// Wenn selectedMission nil ist, gib eine Standardfarbe zurück.
            return Color.blue.opacity(0.2)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                  //  TextField("Neue Mission", text: $newMissionTitle)
                  //      .textFieldStyle(RoundedBorderTextFieldStyle())
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


                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(supermarket) { supermarket in
                                                   SupermarketButtonView(supermarket: supermarket, selectedSupermarket: $selectedSupermarket)
                        }
                    }
                }
                if let selectedSupermarket = selectedSupermarket {
                    SupermarketDetailView(supermarket: selectedSupermarket)
                } else {
                    EmptyView()
                }
                Spacer()
            }
       
            .overlay(
                           Group {
                               if showPopup {
                                   SupermarketPopup(showPopup: $showPopup, newSupermarketTitle: $newSupermarketTitle, addNewSupermarket: addNewSupermarket)
                                       .transition(.scale)
                               }
                           }
                     )
                }
        }
     //   .alert(alertTitle, isPresented: $showAlert) { TextField("", text: $newMissionTitle)
   //         Button("Hinzufügen") {
     //           addNewMission()
    //        }
   //         Button("Abbrechen", role: .cancel) {}
   //     }
  //  }
    func addNewSupermarket() {
        if !newSupermarketTitle.isEmpty {
            let newSupermarket = Supermarket(name: newSupermarketTitle, color: Color.random())
            supermarket.append(newSupermarket)
            newSupermarketTitle = ""
        }
        showPopup = false  //Popup schließen
    }
}

struct SupermarketPopup: View {
    @Binding var showPopup: Bool
    @Binding var newSupermarketTitle: String
    var addNewSupermarket: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("New Task")
                .font(.headline)
                .padding()
            TextField("", text: $newSupermarketTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            HStack {
                Button("Hinzufügen") {
                    addNewSupermarket()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
                
                Button("Abbrechen") {
                    withAnimation {
                        showPopup = false
                    }
                }
                .padding()
                .background(Color.pink)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.pink.opacity(0.3))
        .cornerRadius(10)
        .padding()
        .transition(.scale)
        .zIndex(1)
    
       
    }
      
}


struct SupermarketDetailView: View {
    @ObservedObject var supermarket: Supermarket
    @State private var newItemName = ""
    @State private var struckThroughItem2 = Set<UUID>()
    
    var body: some View {
        VStack {
            Text("Artikel für \(supermarket.name)")
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
                        Text(item.name)
                            .strikethrough(struckThroughItem2.contains(item.id), color: .red)
                            .onTapGesture {
                                if struckThroughItem2.contains(item.id) {
                                    struckThroughItem2.remove(item.id)
                                } else {
                                    struckThroughItem2.insert(item.id)
                                }
                            }
                    }
                }
                .onDelete { indexSet in
                    supermarket.items.remove(atOffsets: indexSet)
                }
            }
        }
    }
}



#Preview {
    ShoppingListView()
}

