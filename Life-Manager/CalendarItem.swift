//
//  CalendarItemView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import Foundation
import SwiftUI

struct CalendarItem: View {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var time: String
    var location: String?
    var participants: [String]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                if description != nil {
                    Text(description!)
                        .font(.caption2)
                }
                Spacer()
                if location != nil {
                    Text(location!)
                        .font(.caption)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(time)
                    .font(.subheadline)
                HStack {
                    ForEach(participants, id: \.self) { item in
                        var firstLetter = item.prefix(1).lowercased()
                        Image(systemName: "\(firstLetter).circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
    }
    
    static var samples: [CalendarItem] {
        [
            CalendarItem(
                title: "Zahnarzt",
                description: "Prophylaxe",
                time: "09:00 - 10:00",
                location: "Praxis Zeit für schöne Zähne",
                participants: ["Mama"]
            ),
            CalendarItem(
                title: "Elterngespräch",
                description: "Gespräch mit Frau Müller",
                time: "14:15 - 14:45",
                location: "Schule, Raum 1.12",
                participants: [
                    "Mama",
                    "Papa",
                    "Sophie"
                ]
            ),
            CalendarItem(
                title: "Fußball",
                time: "15:30 - 17:00",
                location: "Sportverein",
                participants: [
                    "Mama",
                    "Ben"
                ]
            )
        ]
    }
}

#Preview {
    CalendarItem(
        title: "Zahnarzt",
        description: "Prophylaxe",
        time: "09:00 - 10:00",
        location: "Praxis Zeit für schöne Zähne",
        participants: ["Mama", "Sophie"]
    )
}
