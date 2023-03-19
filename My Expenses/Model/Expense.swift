//
//  Expense.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import CoreData

protocol ExpenseType {
    var date: Date? { get set }
    var name: String? { get set }
    var price: Double { get set }
}

// MARK: - Core Data
public class Expense: NSManagedObject, ExpenseType {
    
    // properties are generated automatically
    // matches the properties from the Entity Table
    // date, price, name
    
    // for testing without context
    convenience init(
        _ date: Date? = nil,
        _ name: String? = nil,
        _ price: Double? = 0,
        _ context: NSManagedObjectContext? = nil
    ) {
        self.init(entity: Expense.entity(), insertInto: context)
        self.date = date ?? .init()
        self.name = name ?? ""
        self.price = price ?? 0
    }
}

// MARK: - Test Data
class FakeExpense: ExpenseType, Identifiable {
    var date: Date?
    var name: String?
    var price: Double
    
    init(
        _ date: Date? = nil,
        _ name: String? = nil,
        _ price: Double
    ) {
        self.date = date
        self.name = name
        self.price = price
    }
}
