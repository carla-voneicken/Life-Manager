//
//  Calendar Components and Formatter.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 21.04.25.
//
import Foundation

let calendar: Calendar = {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "de_DE") // Set calendar locale to German so the weekdays are shown in German
    return calendar
}()

func getDaysOfWeek(selectedWeek: Date) -> [Date] {
    // Get the weekInterval for the displayedWeek that is actually a Date
    guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: selectedWeek) else { return [] }
    // Return the interval in form of an array of dates
    return (0..<7).compactMap { day in
        calendar.date(byAdding: .day, value: day, to: weekInterval.start)
    }
}

func stringToDate(dateString: String, timeString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    formatter.locale = Locale(identifier: "de_DE")
    return formatter.date(from: "\(dateString) \(timeString)")
}


extension Date {
    // 15:12
    var shortTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    // 30.04.2025
    var dayShortMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
    
    // April 2025
    var fullMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }
    
    // 30.
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d."
        return formatter.string(from: self)
    }
    
    // 30.4.
    var dayMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d.M."
        return formatter.string(from: self)
    }

    // 30. April
    var dayFullMonth: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d. MMMM"
        return formatter.string(from: self)
    }
    
    // 30. April 2025
    var dayFullMonthYear: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "d. MMMM yyyy"
        return formatter.string(from: self)
    }
    
    // Montag
    var weekday: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
