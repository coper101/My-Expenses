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
protocol ExpenseRepositoryType {
    
    var database: Database { get }
    
    var expenses: [Expense] { get set }
    var expensesPublisher: Published<[Expense]>.Publisher { get }
    
    var todaysExpense: DayExpense? { get set }
    var todaysExpensePublisher: Published<DayExpense?>.Publisher { get }
    
    func getAll() -> [Expense]
    func add(date: Date, name: String, price: Double) -> Void
    func update(_ expense: Expense) -> Void
    
    func getTodaysExpense() -> DayExpense?
    
    func updateToLatestExpense() -> Void
}


// MARK: - App Implementation
final class ExpenseRepository: ObservableObject, ExpenseRepositoryType {
    
    let database: Database
    
    @Published var expenses: [Expense] = []
    var expensesPublisher: Published<[Expense]>.Publisher { $expenses }
    
    @Published var todaysExpense: DayExpense?
    var todaysExpensePublisher: Published<DayExpense?>.Publisher { $todaysExpense }
    
    init(database: Database = LocalDatabase(container: .myExpenses)) {
        self.database = database
        
        database.loadContainer { _ in
            
        } onSuccess: { [weak self] in
            guard let self else {
                return
            }
            self.updateToLatestExpense()
        }
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
    
    func getTodaysExpense() -> DayExpense? {
        let calendar = Calendar.current
        let startDate = Calendar.current.startOfDay(for: .init())
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let dateAttribute = "date"
        
        do {
            let items = try getDataWith(
                format: "(\(dateAttribute) >= %@) AND (\(dateAttribute) < %@)",
                startDate as NSDate,
                endDate as NSDate,
                sortDescriptors: [.init(key: dateAttribute, ascending: true)]
            )
            return .init(date: startDate, items: items)
            
        } catch let error {
            Logger.database.error("get todays expense - error: \(error.localizedDescription)")
            return .init(date: startDate, items: [])
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
        expenses = getAll()
        todaysExpense = getTodaysExpense()
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
    
    func getDataWith(
        format: String,
        _ args: CVarArg...,
        sortDescriptors: [NSSortDescriptor] = []
    ) throws -> [Expense] {
        let request = Expense.fetchRequest()
        request.sortDescriptors = sortDescriptors
        request.predicate = .init(format: format, args)
        return try database.context.fetch(request)
    }
}

