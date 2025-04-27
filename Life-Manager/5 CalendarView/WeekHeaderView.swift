//
//  WeekHeaderView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 27.04.25.
//

import SwiftUI

struct WeekHeaderView: View {
    @Binding var displayedWeek: Date
    
    // Users current calendar settings (e.g. locale and first day of the week)
    var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM" // full month name and year
        formatter.locale = Locale(identifier: "de_DE") // get the German month names
        return formatter
    }()
    
    // Function to change the month (if the calculation fails, fall back to the current value)
    private func changeWeek(by value: Int) {
        displayedWeek = calendar.date(byAdding: .weekOfYear, value: value, to: displayedWeek) ?? displayedWeek
    }
    
    var body: some View {
        // Left arrow - currently displayed month - right arrow (tapping arrow calls the changeMonth function)
        HStack {
            Button(action: { changeWeek(by: -1) }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(formatter.string(from: displayedWeek))
                .font(.headline)
            Spacer()
            Button(action: { changeWeek(by: 1) }) {
                Image(systemName: "chevron.right")
            }
        }
        .tint(.primary)
        .padding(.horizontal)
    }
}

