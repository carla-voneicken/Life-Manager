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
            ),
            CalendarItem(
                title: "Kinderarzt",
                startDate: stringToDate(dateString: "2025-04-23", timeString: "10:30")!,
                endDate: stringToDate(dateString: "2025-04-23", timeString: "11:00")!,
                location: "Kinderarzt",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[3]]
            ),
            CalendarItem(
                title: "Ballett",
                startDate: stringToDate(dateString: "2025-04-24", timeString: "15:30")!,
                endDate: stringToDate(dateString: "2025-04-24", timeString: "17:00")!,
                location: "Tanzstudio",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[2]]
            ),
            CalendarItem(
                title: "Besuch Oma und Opa",
                startDate: stringToDate(dateString: "2025-04-26", timeString: "14:00")!,
                endDate: stringToDate(dateString: "2025-04-26", timeString: "18:00")!,
                location: "Zuhause",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[1], FamilyMember.familyMembers[2], FamilyMember.familyMembers[3]]
            ),
            CalendarItem(
                title: "Musical",
                startDate: stringToDate(dateString: "2025-04-27", timeString: "20:00")!,
                endDate: stringToDate(dateString: "2025-04-27", timeString: "22:00")!,
                location: "Stadttheater",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[2]]
            ),
            CalendarItem(
                title: "Geigenvorspiel",
                startDate: stringToDate(dateString: "2025-04-28", timeString: "16:00")!,
                endDate: stringToDate(dateString: "2025-04-28", timeString: "17:00")!,
                location: "Schule",
                participants: [FamilyMember.familyMembers[0], FamilyMember.familyMembers[1], FamilyMember.familyMembers[2], FamilyMember.familyMembers[3]]
            ),
            CalendarItem(
                title: "Mama-Treffen",
                startDate: stringToDate(dateString: "2025-04-29", timeString: "20:00")!,
                endDate: stringToDate(dateString: "2025-04-29", timeString: "23:00")!,
                location: "Sportverein",
                participants: [FamilyMember.familyMembers[0]]
            ),
            
        ]
}


