import SwiftUI

struct WeekGridSubview: View {
    
    let displayedWeek: Date
    var daysOfWeek: [Date] {
        getDaysOfWeek(selectedWeek: displayedWeek)
    }
    let hours = Array(0..<24)
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 0), count: 8)
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Header Row
            LazyVGrid(columns: columns, spacing: 0) {
                // Empty top-left corner
                Text("")
                    .frame(height: 30)
                
                // Day headers
                ForEach(daysOfWeek, id: \.self) { date in
                    Text(date.weekday.prefix(1))
                        .frame(height: 30)
                        .font(.footnote)
                        .frame(maxWidth: .infinity)
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
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Calendar.current.isDateInToday(date) ? Color.primary : .clear)
                                .padding(-3)
                        }
                }
            }
            .padding(.bottom)
            
            Divider()
            
            
            // MARK: Grid Body
            ScrollView(showsIndicators: true) {
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
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    private func cellView(content: String, isHourLabel: Bool = false) -> some View {
        ZStack {
            if !isHourLabel {
                Rectangle()
                    .fill(Color.white)
            }
            
            Text(content == "00:00" ? "" : content)
                .font(.footnote)
                .foregroundColor(.black)
                .offset(y: isHourLabel ? -25 : 0) // Half the cell height
        }
        .frame(height: 50)
        .overlay(
            Rectangle()
                .frame(width: !isHourLabel ? 0.5 : 0) // width = 0 aka invisible when the cell contains an hour lable
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .trailing
        )
        .overlay(
            Rectangle()
                .frame(height: !isHourLabel ? 0.5 : 0)
                .foregroundColor(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
        
    }
}

#Preview {
    WeekGridSubview(displayedWeek: Date())
}
