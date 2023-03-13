//
//  Date.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import Foundation

extension String {
    
    /// Converts ISO String Date to Date
    func toDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self) ?? Date()
    }
    
}

extension Date {
    
    /// Formats the Date to `MM Week n`
    /// e.g. Feb, Week 1
    func toMonthAndWeekFormat() -> String {
        let weekNumber = self.toDateComp().weekOfMonth ?? 1
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let weekFormat = dateFormatter.string(from: self)
        return "\(weekFormat) \(weekNumber)"
    }
    
    func getWeekday() -> Int {
        self.toDateComp().weekday!
    }
    
    func toDateComp() -> DateComponents {
        Calendar.current.dateComponents(
            [.day, .month, .year, .weekday],
            from: self
        )
    }
    
}
