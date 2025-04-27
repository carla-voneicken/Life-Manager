//
//  CalndarWeeklyView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 27.04.25.
//

import SwiftUI

struct CalendarWeeklyView: View {
    @State var todaysDate: Date = Date()
    @State var selectedDate: Date? = Date()

    var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE")
        return calendar
    }()
    
    var body: some View {
        let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        let hours = Array(0..<24) // 0 to 23
        
        ScrollView {
            VStack(spacing: 0) {
                // Header: Days
                VStack {
                    WeekHeaderView(displayedWeek: $todaysDate)
                    HStack(spacing: 0) {
                        Text("") // Empty top-left corner
                            .frame(width: 40) // Adjust for hour labels
                        WeekdayHeaderView()
                    }
                }
                .padding(.vertical)
                
                // Grid: Hours x Days
                ForEach(hours, id: \.self) { hour in
                    HStack(spacing: 0) {
                        Text(String(format: "%02d:00", hour))
                            .frame(width: 38)
                            .font(.footnote)
                            .padding(2)
                        
                        ForEach(daysOfWeek, id: \.self) { day in
                            Rectangle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                .frame(height: 40) // each hour row height
                                .background(Color.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalendarWeeklyView()
}
