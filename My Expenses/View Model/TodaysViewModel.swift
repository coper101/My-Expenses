//
//  TodaysViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 18/3/23.
//

import Combine
import SwiftUI

final class TodaysViewModel: ObservableObject {
    
    private let expenseRepository: ExpenseRepositoryType
    private var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: Data
    @Published var todaysExpense: DayExpense?
    @Published var expenses: [Expense] = []
    
    // MARK: UI
    
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
            .sink { [weak self] in
                print("todays expense: ", $0?.items.count ?? 0)
                self?.todaysExpense = $0
                
            }
            .store(in: &subscriptions)
    }
    
    func observeExpenses() {
        expenseRepository.expensesPublisher
            .sink { [weak self] in self?.expenses = $0 }
            .store(in: &subscriptions)
    }
    
    func didTapDeleteExpense(_ expense: ExpenseType) {
        guard let expense = expense as? Expense else {
            return
        }
        expenseRepository.delete(expense)
    }
}
