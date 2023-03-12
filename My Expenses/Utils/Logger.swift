//
//  Logger.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import OSLog

extension Logger {
    
    enum Category: String {
        case appModel = "appmodel"
        case localDatabase = "localdatabase"
        case expenseRepository = "expenserepository"
    }
    
    // App
    static let appModel = createLogger(of: .appModel)
    static let expenseRepository = createLogger(of: .expenseRepository)
    static let database = createLogger(of: .localDatabase)
    
    static func createLogger(of category: Category) -> Logger {
        let subsystem = Bundle.main.bundleIdentifier!
        return .init(subsystem: subsystem, category: category.rawValue)
    }
}


