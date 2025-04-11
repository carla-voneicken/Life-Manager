//
//  TodayView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct TodayView: View {
    
    @State private var calendarItemsToday = CalendarItem.samples
    @State private var taskItemsToday = TaskItem.samples
    
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
                
                Text("Aufgaben")
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.top)
                
                List($taskItemsToday, id: \.id) { $item in
                    NavigationLink(destination: TaskDetailView(item: item)) {
                        TaskItemView(item: $item)
                    }
                }
                
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Heute, \(formattedDate)")
            .toolbar {
                
                Button {
                    print("About tapped!")
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 30, height: 25)
                        .tint(.black)
                }
                
                Button {
                    ProfileView()
                } label: {
                    Image("profilepicture")
                        .resizable()
                        .frame(width: 40, height: 40)
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
