//
//  TabViewEnum.swift
//  Life-Manager
//
//  Created by Christiane Roth on 13.04.25.
//
import SwiftUI

enum TabViewEnum: Identifiable, CaseIterable, View {
    case todayView, calendarView, familyView, shoppingListView, toDoView
    var id: Self { self }
    
    var tabItem: TabItem {
        switch self {
        case .todayView:
                .init(name: "Today", systemImage: "sunrise.fill")
        case .calendarView:
                .init(name: "Calendar", systemImage: "calendar")
        case .familyView:
                .init(name: "Family", systemImage: "person.crop.circle")
        case .shoppingListView:
                .init(name: "Shopping", systemImage: "cart")
        case .toDoView:
                .init(name: "Todo", systemImage: "list.bullet")
        }
    }
    
    var body: some View {
        switch self {
        case .todayView:
            TodayView()
        case .calendarView:
            MonthlyCalendarView()
        case .familyView:
            FamilyView()
        case .shoppingListView:
            ShoppingListView()
      
        case .toDoView:
            ToDoView()
        }
    }
}

