//
//  dateConverter.swift
//  Life-Manager
//
//  Created by Carla von Eicken on 21.04.25.
//
import Foundation

func stringToDate(dateString: String, timeString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    formatter.locale = Locale(identifier: "de_DE")
    return formatter.date(from: "\(dateString) \(timeString)")
}


extension Date {
    var shortTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
