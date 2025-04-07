//
//  ShoppingListView.swift
//  Life-Manager
//
//  Created by Christiane Roth on 01.04.25.
//
import SwiftUI


struct ShoppingListView: View {
    @State private var newItem1 = ""
    @State private var shoppingList = ["Hähnchen", "Eier", "Milch", "Brot"]
    @State private var newItem = ""
    @State private var struckThroughItems = Set<String>()//false
    
    
    @State private var supermarket = ["Edeka", "Aldi", "Lidl"]
    //let colors: [Color] = [.blue, .green, .yellow, .orange, .red]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(supermarket, id: \.self) { item in
                Text(item)
                    .frame(width: 75, height: 75)
                    .textFieldStyle(.roundedBorder)
               
                }

            }
            
          //  TextField("Add Supermarket", text: $newItem1)
          //      .textFieldStyle(RoundedBorderTextFieldStyle())
         //   ViewThatFits(in: /*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/) {
        //        /*@START_MENU_TOKEN@*/Text("Content")/*@END_MENU_TOKEN@*/
         //   }
        }
        NavigationStack {
            VStack {
                HStack {
                    TextField("Neue Liste", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        if !newItem.isEmpty {
                            shoppingList.append(newItem)
                            newItem = ""
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(newItem.isEmpty)
                }
                
                .padding()
                List {
                    ForEach(shoppingList, id: \.self) { item in
                        HStack {
                            Text(item)
                                .strikethrough(struckThroughItems.contains(item), color: .red)
                                .onTapGesture {
                                    if struckThroughItems.contains(item) {
                                        struckThroughItems.remove(item)
                                    } else {
                                        struckThroughItems.insert(item)
                                    }
                                }
                            }
                    }
                    .onDelete {indexSet in
                        shoppingList.remove(atOffsets: indexSet)
                    }
                    .listStyle(.plain)
                    .navigationTitle("Einkaufsliste")
                }
            }
        }
    }
}
    #Preview {
            ShoppingListView()
}


