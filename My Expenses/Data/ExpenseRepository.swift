//
//  ExpenseRepository.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Foundation
import Combine
import CoreData
import OSLog

// MARK: Protocol
protocol ExpenseType {
    
    var database: Database { get }
    
    var expenses: [Expense] { get set }
    var expensesPublisher: Published<[Expense]>.Publisher { get }
    
    func getAll() -> [Expense]
    func add(date: Date, name: String, price: Double) -> Void
    func update(_ expense: Expense) -> Void
}


// MARK: - App Implementation
final class ExpenseRepository: ObservableObject, ExpenseType {
    
    let database: Database
    
    @Published var expenses: [Expense] = []
    var expensesPublisher: Published<[Expense]>.Publisher { $expenses }
    
    init(database: Database = LocalDatabase(container: .myExpenses)) {
        self.database = database
    }
    
    func getAll() -> [Expense] {
        do {
            let request = NSFetchRequest<Expense>(entityName: Entities.expense.name)
            return try database.context.fetch(request)
        } catch let error {
            Logger.database.error("get all - error: \(error.localizedDescription)")
            return []
        }
    }
    
    func add(
        date: Date,
        name: String,
        price: Double
    ) {
        do {
            let expense = Expense(context: database.context)
            expense.date = date
            expense.name = name
            expense.price = price
            let isAdded = try database.context.saveIfNeeded()
            guard isAdded else {
                return
            }
            updateToLatestExpense()
        } catch let error {
            Logger.expenseRepository.error("add - error: \(error.localizedDescription)")
        }
    }
    
    func update(_ expense: Expense) {
        do {
            let isUpdated = try database.context.saveIfNeeded()
            if isUpdated {
                updateToLatestExpense()
            }
        } catch let error {
            Logger.database.error("update - error: \(error.localizedDescription)")
        }
    }
    
    func updateToLatestExpense() {
        
    }
    
}

extension ExpenseRepository {
    
    func getAllWith(
        format: String,
        _ args: CVarArg...,
        sortDescriptors: [NSSortDescriptor] = []
    ) throws -> [Expense] {
        let request = NSFetchRequest<Expense>(entityName: Entities.expense.name)
        request.sortDescriptors = sortDescriptors
        request.predicate = .init(format: format, args)
        return try database.context.fetch(request)
    }
}


// MARK: - Test Implementation
final class MockExpenseRepository: ObservableObject, ExpenseType {
    
    let database: Database
    
    @Published var expenses: [Expense] = []
    var expensesPublisher: Published<[Expense]>.Publisher { $expenses }
    
    init(database: Database = InMemoryLocalDatabase(container: .myExpenses)) {
        self.database = database
    }
    
    func getAll() -> [Expense] {
        []
    }
    
    func add(date: Date, name: String, price: Double) {
        
    }
    
    func update(_ expense: Expense) {
        
    }
    
}
