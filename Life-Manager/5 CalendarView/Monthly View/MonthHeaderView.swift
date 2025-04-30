//
//  MonthHeaderView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 27.04.25.
//

import SwiftUI

struct MonthHeaderView: View {
    @Binding var displayedMonth: Date
    
    // Function to change the month (if the calculation fails, fall back to the current value)
    private func changeMonth(by value: Int) {
        displayedMonth = calendar.date(byAdding: .month, value: value, to: displayedMonth) ?? displayedMonth
    }
    
    var body: some View {
        // Left arrow - currently displayed month - right arrow (tapping arrow calls the changeMonth function)
        HStack {
            Button(action: { changeMonth(by: -1) }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            Text(displayedMonth.fullMonthYear)
                .font(.headline)
            Spacer()
            Button(action: { changeMonth(by: 1) }) {
                Image(systemName: "chevron.right")
            }
        }
        .tint(.primary)
        .padding(.horizontal)
    }
}

