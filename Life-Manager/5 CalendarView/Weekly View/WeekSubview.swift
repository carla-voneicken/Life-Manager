import SwiftUI

struct WeekSubview: View {
    
    let displayedWeek: Date
    
    var daysOfWeek: [Date] {
        getDaysOfWeek(selectedWeek: displayedWeek)
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
    WeekSubview(displayedWeek: Date())
}
