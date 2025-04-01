//
//  TodayView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct TodayView: View {
    
    @State private var calendarItemsToday = CalendarItem.samples
    
    let date: Date = Date()
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Termine")
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.top)
                
                List(calendarItemsToday, id: \.id) { item in
                    NavigationLink(destination: CalendarDetailView(item: item)) {
                        CalendarItemView(item: item)
                    }
                }
                
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Heute, \(formattedDate)")
            .toolbar {
                
                Button {
                    print("About tapped!")
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .tint(.black)
                }
                
                Button {
                    print("Help tapped!")
                } label: {
                    Image("profilepicture")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .tint(.green)
                        .clipShape(Circle())
                }
            }
        }
    }
}


#Preview {
    TodayView()
}
