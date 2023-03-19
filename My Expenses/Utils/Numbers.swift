//
//  Numbers.swift
//  My Expenses
//
//  Created by Wind Versi on 19/3/23.
//

import Foundation

extension Double {
    
    /// Returns a formatted number with n no of decimal places
    func formatTo(dp: Int) -> String {
        String(format: "%.\(dp)f", self)
    }
}

func getTotalPrice(items: [any ExpenseType]) -> String {
    let total = items
        .map(\.price)
        .reduce(0) { $0 + $1 }
    return total.formatTo(dp: 2)
}
