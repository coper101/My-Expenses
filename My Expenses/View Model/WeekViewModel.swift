//
//  WeekViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 18/3/23.
//

import Foundation
import Combine

final class WeekViewModel {
    
    private var subscriptions: Set<AnyCancellable> = .init()
    private let expenseRepository: ExpenseRepositoryType
    
    // MARK: UI State
    @Published var weekExpenses: [WeekExpense] = []

    init(expenseRepository: ExpenseRepositoryType) {
        self.expenseRepository = expenseRepository
        
        observeExpenses()
    }
    
    // MARK: Event
    func observeExpenses() {
        expenseRepository.expensesPublisher
            .sink { [weak self] expenses in
                
                // Date: [Expense]
                let dayExpenses =
                    Dictionary(grouping: expenses) { expense in
                        let date = Calendar.current.startOfDay(for: expense.date ?? .init())
                        return date
                    }
                    .map { DayExpense(date: $0, items: $1) }
                
                // Date Interval: [DayExpense]
                let startDate = Calendar.current.startOfDay(for: "2023-02-01T00:00:00+00:00".toDate())
                let endDate = Calendar.current.startOfDay(for: "2023-02-28T00:00:00+00:00".toDate())
                
                self?.weekExpenses = [
                    WeekExpense(
                        dateInterval: .init(start: startDate, end: endDate),
                        dayExpenses: dayExpenses
                    )
                ]
            }
            .store(in: &subscriptions)
    }
}
