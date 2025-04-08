//
//  ContentView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       TabView {
           TodayView()
               .tabItem {
                   Label("Heute", systemImage: "house.fill")
               }
           ToDoview()
               .tabItem {
                   Label("Aufgaben", systemImage: "checklist")
               }
           CalendarView()
               .tabItem {
                   Label("Kalendar", systemImage: "calendar")
               }
           FamilyView()
               .tabItem {
                   Label("Familie", systemImage: "person.3.fill")
               }
           ShoppingListView()
               .tabItem {
                   Label("Einkaufen", systemImage: "cart.fill")
               }
        }
    }
}

#Preview {
    ContentView()
}
