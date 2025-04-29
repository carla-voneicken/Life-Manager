import SwiftUI

struct WeeklyCalendarView: View {
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
    }()
    
    let hours = Array(0..<24)
    
    @State var displayedWeek: Date = Date()
    var daysOfWeek: [Date] {
        // Get the weekInterval for the displayedWeek that is actually a Date
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: displayedWeek) else { return [] }
        // Return the interval in form of an array of dates
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: weekInterval.start)
        }
    }
    
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d."
        return formatter
    }()

    let dayMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d. MMMM"
        return formatter
    }()
    
    let dayMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d. MMMM yyyy"
        return formatter
    }()

    // 1 fixed column (hours) + 7 flexible columns (days)
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    }

    var body: some View {
        HStack {
            Button(action: { changeWeek(by: -1) }) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            
            // Display week interval
            if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .month) {
                // Same month → only show full month once
                Text("\(dayFormatter.string(from: daysOfWeek[0])) - \(dayMonthFormatter.string(from: daysOfWeek[6]))")
            } else {
                if calendar.isDate(daysOfWeek[0], equalTo: daysOfWeek[6], toGranularity: .year) {
                        // Different months, same year → show month on both
                        Text("\(dayMonthFormatter.string(from: daysOfWeek[0])) - \(dayMonthFormatter.string(from: daysOfWeek[6]))")
                    } else {
                        // Different months and year → show month and year on both
                        Text("\(dayMonthYearFormatter.string(from: daysOfWeek[0])) - \(dayMonthYearFormatter.string(from: daysOfWeek[6]))")
                    }
            }
            Spacer()
            Button(action: { changeWeek(by: 1) }) {
                Image(systemName: "chevron.right")
            }
        }
        .tint(.primary)
        .padding()
        
        ScrollView {
            // MARK: Header Row
            LazyVGrid(columns: columns, spacing: 0) {
                // Empty top-left corner
                Text("")
                    .frame(height: 30)

                // Day headers
                ForEach(daysOfWeek, id: \.self) { date in
                    Text(date.formatted(Date.FormatStyle().weekday(.short)))
                        .frame(height: 30)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                }
            }
            
            LazyVGrid(columns: columns, spacing: 0) {
                // Empty top-left corner
                Text("")
                    .frame(height: 30)

                // Day headers
                ForEach(daysOfWeek, id: \.self) { date in
                    Text(date.formatted(Date.FormatStyle().day(.twoDigits)))
                        .frame(height: 30)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                }
            }

            // MARK: Grid Body
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(hours, id: \.self) { hour in
                    // Hour label column
                    cellView(content: String(format: "%02d:00", hour), isHourLabel: true)

                    // Day columns
                    ForEach(0..<7, id: \.self) { _ in
                        cellView(content: "")
                    }
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        // Swiped left → next week
                        changeWeek(by: 1)
                    } else if value.translation.width > 50 {
                        // Swiped right → previous week
                        changeWeek(by: -1)
                    }
                }
        )
    }
    
    @ViewBuilder
    private func cellView(content: String, isHourLabel: Bool = false) -> some View {
        ZStack {
            Rectangle()
                .fill(isHourLabel ? Color.gray.opacity(0.1) : Color.white)
            
            Text(content)
                .font(.footnote)
        }
        .frame(height: 50)
        .overlay(
            Rectangle() // Right border
                .frame(width: 0.5)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .trailing
        )
        .overlay(
            Rectangle() // Bottom border
                .frame(height: 0.5)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .bottom
        )

    }
    
    private func changeWeek(by value: Int) {
        displayedWeek = calendar.date(byAdding: .weekOfYear, value: value, to: displayedWeek) ?? displayedWeek
    }
    
}


#Preview {
    WeeklyCalendarView()
}
