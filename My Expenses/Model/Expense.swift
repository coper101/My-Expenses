//
//  Expense.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import CoreData

public class Expense: NSManagedObject {
    
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

func createFakeExpense(
    date: Date? = nil,
    name: String? = nil,
    price: Double? = 0
) -> Expense {
    .init(date, name, price)
}
