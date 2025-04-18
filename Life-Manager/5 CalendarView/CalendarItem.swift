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
    var time: String
    var location: String?
    var participants: [FamilyMember]
    
    
    static var samples: [CalendarItem] =
        [
            CalendarItem(
                title: "Zahnarzt",
                description: "Prophylaxe",
                time: "09:00 - 10:00",
                location: "Praxis Zeit für schöne Zähne",
                participants: [FamilyMember.familyMembers[0]]
            ),
            CalendarItem(
                title: "Elterngespräch",
                description: "Gespräch mit Frau Müller",
                time: "14:15 - 14:45",
                location: "Schule, Raum 1.12",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[1], FamilyMember.familyMembers[2]]
            ),
            CalendarItem(
                title: "Fußball",
                time: "15:30 - 17:00",
                location: "Sportverein",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[3]]
            )
        ]
}


