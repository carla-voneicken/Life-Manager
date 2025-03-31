//
//  TodayView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct TodayView: View {
    @State private var calendarItemsToday = CalendarItem.samples
    
    var body: some View {
//        VStack {
//            ForEach(calendarItemsToday) { item in
//                ContentView(calendarItem: item)
//            }
//        }
        NavigationStack {
            List(calendarItemsToday, id: \.id) { item in
                NavigationLink(destination: CalendarDetailView(item: item)) {
                    item // Display the CalendarItem as the row
                }
            }
            .navigationTitle("Calendar Events")
        }
    }
    
}

#Preview {
    TodayView()
}
