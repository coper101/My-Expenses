//
//  Test.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import Foundation
import CoreData

class TestData {
    
    // MARK: Fake Type
    static var todaysExpenseDate: Date = "2023-02-01T00:00:00+00:00".toDate()
    
    static func createExpensesForTheDay(day: Int, month: Int, year: Int) -> [FakeExpense] {
        let monthWithPadding = String(format: "%02d", month)
        let dayWithPadding = String(format: "%02d", day)
        return [
            .init("\(year)-\(monthWithPadding)-\(dayWithPadding)T\(09):00:00+80:00".toDate(), "Train", 1.97),
            .init("\(year)-\(monthWithPadding)-\(dayWithPadding)T\(12):00:00+80:00".toDate(), "Lunch", 4.5),
            .init("\(year)-\(monthWithPadding)-\(dayWithPadding)T\(16):00:00+80:00".toDate(), "Snacks", 2.3),
            .init("\(year)-\(monthWithPadding)-\(dayWithPadding)T\(19):00:00+80:00".toDate(), "Snacks", 1.97),
            .init("\(year)-\(monthWithPadding)-\(dayWithPadding)T\(20):30:00+80:00".toDate(), "Dinner", 7.4)
        ]
    }
    
    static var sampleExpenses: [FakeExpense] = {
        var items: [FakeExpense] = []
        let dayRange = 1...3
        let month = 2
        let year = 2023
        dayRange.forEach { day in
            let dayExpenses = createExpensesForTheDay(day: day, month: month, year: year)
            items.append(contentsOf: dayExpenses)
        }
        return items
    }()
    
    static var sampleExpense: FakeExpense = .init(
        "2023-02-01T14:00:00+00:00".toDate(),
        "Bus",
        2.50
    )
    
    static var sampleDayExpense: DayExpense = .init(
        date: "2023-02-01T14:00:00+00:00".toDate(),
        items: sampleExpenses
    )
    
    static var sampleWeekExpenseEmpty: WeekExpense = .init(
        dateInterval: .init(
            start: "2023-02-01T14:00:00+00:00".toDate(),
            end: "2023-02-04T14:00:00+00:00".toDate()
        ),
        dayExpenses: []
    )
}

extension TestData {
    
    // MARK: - Dependencies
    static var repository: ExpenseRepository = {
        let repo = ExpenseRepository(database: InMemoryLocalDatabase(container: .myExpenses))
        
        TestData.sampleExpenses.forEach { fakeExpense in
            let expense = Expense(context: repo.database.context)
            expense.date = fakeExpense.date
            expense.name = fakeExpense.name
            expense.price = fakeExpense.price
        }
        
        let _ = try? repo.database.context.saveIfNeeded()
        
        repo.updateToLatestExpense()
        
        return repo
    }()
    
    static var weekViewModel: WeekViewModel = {
        let viewModel = WeekViewModel(expenseRepository: repository)
        return viewModel
    }()
}
