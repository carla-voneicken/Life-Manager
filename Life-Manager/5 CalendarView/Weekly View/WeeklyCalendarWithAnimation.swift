import SwiftUI

struct WeeklyCalendarWithAnimationView: View {
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
        return calendar
    }()
    
    @State private var currentDate: Date = Date()
    @State private var dragOffset: CGFloat = 0
    @State private var currentIndex: Int = 1 // Middle of 3 views
    
    var daysOfWeek: [Date] {
        // Get the weekInterval for the displayedWeek that is actually a Date
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: currentDate) else { return [] }
        // Return the interval in form of an array of dates
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: weekInterval.start)
        }
    }
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
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
        
        let dates = [
            Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!,
            currentDate,
            Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
        ]
        
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(dates, id: \.self) { date in
                    WeekView(displayedWeek: date)
                        .frame(width: geometry.size.width)
                }
            }
            .offset(x: -geometry.size.width + dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = geometry.size.width / 3
                        
                        if value.translation.width < -threshold {
                            // Swipe left → next week
                            withAnimation(.easeInOut) {
                                dragOffset = -geometry.size.width
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                currentDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentDate)!
                                dragOffset = 0
                            }
                        } else if value.translation.width > threshold {
                            // Swipe right → previous week
                            withAnimation(.easeInOut) {
                                dragOffset = geometry.size.width
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                currentDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
                                dragOffset = 0
                            }
                        } else {
                            // Not far enough — snap back
                            withAnimation(.easeOut) {
                                dragOffset = 0
                            }
                        }
                    }
            )
        }
    }
    
    private func changeWeek(by value: Int) {
        currentDate = calendar.date(byAdding: .weekOfYear, value: value, to: currentDate) ?? currentDate
    }
}



struct WeekView: View {
    let displayedWeek: Date
    let calendar = Calendar(identifier: .gregorian)
    
    var daysOfWeek: [Date] {
        // Get the weekInterval for the displayedWeek that is actually a Date
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: displayedWeek) else { return [] }
        // Return the interval in form of an array of dates
        return (0..<7).compactMap { day in
            calendar.date(byAdding: .day, value: day, to: weekInterval.start)
        }
    }
    
    let hours = Array(0..<24)
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    }
    
    var body: some View {
        ScrollView {
            // MARK: Header Row
            LazyVGrid(columns: columns, spacing: 0) {
                // Empty top-left corner
                Text("")
                    .frame(height: 30)

                // Day headers
                ForEach(daysOfWeek, id: \.self) { date in
                    Text(date.weekday.prefix(2))
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
}

#Preview {
    WeeklyCalendarWithAnimationView()
}
