//
//  CalendarItemView.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 31.03.25.
//

import Foundation

struct CalendarItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String?
    var startDate: Date
    var endDate: Date
    var location: String?
    var participants: [FamilyMember]
    
    
    static var samples: [CalendarItem] =
        [
            CalendarItem(
                title: "Zahnarzt",
                description: "Prophylaxe",
                startDate: stringToDate(dateString: "2025-04-21", timeString: "09:00")!,
                endDate: stringToDate(dateString: "2025-04-21", timeString: "10:00")!,
                location: "Praxis Zeit für schöne Zähne",
                participants: [FamilyMember.familyMembers[0]]
            ),
            CalendarItem(
                title: "Elterngespräch",
                description: "Gespräch mit Frau Müller",
                startDate: stringToDate(dateString: "2025-04-21", timeString: "14:15")!,
                endDate: stringToDate(dateString: "2025-04-21", timeString: "14:45")!,
                location: "Schule, Raum 1.12",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[1], FamilyMember.familyMembers[2]]
            ),
            CalendarItem(
                title: "Fußball",
                startDate: stringToDate(dateString: "2025-04-21", timeString: "15:30")!,
                endDate: stringToDate(dateString: "2025-04-21", timeString: "17:00")!,
                location: "Sportverein",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[3]]
            )
        ]
}


