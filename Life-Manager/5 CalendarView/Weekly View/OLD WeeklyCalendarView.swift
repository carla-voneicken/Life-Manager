//
//  CalndarWeeklyView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 27.04.25.
//

import SwiftUI

struct CalendarWeeklyView: View {
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
    }()
    
    @State var displayedWeek: Date = Date()
    
    var daysOfWeek: [Date] {
        // Get the weekInterval for the displayedWeek that is actually a Date
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: displayedWeek) else { return [] }
        // Return the interval in form of an array of dates
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: weekInterval.start)
        }
    }

    let hours = Array(0..<24) // 0 to 23""
    
    var body: some View {
        let sidebarWidth: CGFloat = 45

        ScrollView {
            VStack(spacing: 0) {
                // Header displaying the week interval, weekdays and dates
                VStack {
                    // MARK: Display of week interval and navigation arrows
                    HStack {
                        Button(action: { changeWeek(by: -1) }) {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        
                        // Display week interval
                        if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .month) {
                            // Same month → only show full month once
                            Text("\(daysOfWeek[0].day) - \(daysOfWeek[6].dayMonth)")
                        } else {
                            if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .year) {
                                    // Different months, same year → show month on both
                                Text("\(daysOfWeek[0].dayMonth) - \(daysOfWeek[6].dayMonth)")
                                } else {
                                    // Different months and year → show month and year on both
                                    Text("\(daysOfWeek[0].dayMonthYear) - \(daysOfWeek[6].dayMonthYear)")
                                }
                        }
                        Spacer()
                        Button(action: { changeWeek(by: 1) }) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .tint(.primary)
                    .padding()
                    
                    // MARK: Display of weekdays
                    HStack(spacing: 0) {
                        Text("") // Empty top-left corner
                            .frame(width: sidebarWidth) // Adjust for hour labels
                        WeekdayHeaderView()
                    }
                    
                    // MARK: Display of dates of the columns
                    HStack(spacing: 0) {
                        Text("") // Empty top-left corner
                            .frame(width: sidebarWidth) // Adjust for hour labels
                        ForEach(daysOfWeek, id:\.self) { day in
                            Text("\(calendar.component(.day, from: day))")
                                .font(.system(size: 15))
                                .frame(maxWidth: .infinity) // make each day take equal space in the row
                        }
                    }
                }
                .padding(.vertical)
                
                // MARK: Grid of hours and days
                ForEach(hours, id: \.self) { hour in
                    HStack(spacing: 0) {
                        Text(String(format: "%02d:00", hour))
                            .frame(width: sidebarWidth)
                            .font(.footnote)
                            .padding(2)
                        
                        ForEach(daysOfWeek, id: \.self) { day in
                            Rectangle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                                .frame(height: sidebarWidth)
                                .background(Color.white)
                        }
                    }
                }
            }
        }
    }
    
    private func changeWeek(by value: Int) {
        displayedWeek = calendar.date(byAdding: .weekOfYear, value: value, to: displayedWeek) ?? displayedWeek
    }
    
}

#Preview {
    CalendarWeeklyView()
}
