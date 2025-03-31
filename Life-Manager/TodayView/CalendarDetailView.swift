//
//  CalendarDetailView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import SwiftUI

struct CalendarDetailView: View {
    var item: CalendarItem
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                
                if let description = item.description {
                    Text(description)
                        .font(.subheadline)
                }
                
                Text("Uhrzeit: \(item.time)")
                    .font(.headline)
                
                if let location = item.location {
                    Text("Ort: \(location)")
                        .font(.subheadline)
                }
                
                Text("Teilnehmer: \(item.participants.joined(separator: ", "))")
                    .font(.subheadline)
            }
            .padding()
        }
}

#Preview {
    CalendarDetailView(item:
        CalendarItem(
            title: "Zahnarzt",
            description: "Prophylaxe",
            time: "09:00 - 10:00",
            location: "Praxis Zeit für schöne Zähne",
            participants: ["Mama", "Sophie"]
        )
    )
}
