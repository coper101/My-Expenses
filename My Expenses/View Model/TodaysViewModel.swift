//
//  TodaysViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 18/3/23.
//

import Foundation
import Combine

final class TodaysViewModel {
    
    private let expenseRepository: ExpenseRepositoryType
    private var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: UI State
    @Published var todaysExpense: DayExpense?
    @Published var expenses: [Expense] = []

    var totalPrice: String {
        getTotalPrice(items: todaysExpense?.items ?? [])
    }
    
    init(expenseRepository: ExpenseRepositoryType) {
        self.expenseRepository = expenseRepository
        
        observeTodaysExpense()
        observeExpenses()
    }
    
    // MARK: Event
    func observeTodaysExpense() {
        expenseRepository.todaysExpensePublisher
            .sink { [weak self] in self?.todaysExpense = $0 }
            .store(in: &subscriptions)
    }
    
    func observeExpenses() {
        expenseRepository.expensesPublisher
            .sink { [weak self] in self?.expenses = $0 }
            .store(in: &subscriptions)
    }
}
