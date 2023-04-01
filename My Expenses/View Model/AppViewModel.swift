//
//  AppViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Combine

final class AppViewModel: ObservableObject {
    
    let expenseRepository: ExpenseRepositoryType
    
    // MARK: Data
    @Published var weekExpenses: [WeekExpense] = []
    
    // MARK: UI
    @Published var selectedTab: TabItem = .today
    @Published var isNewItemFocused: Bool = false
    @Published var isEditing: Bool = false
    @Published var isCustomizing: Bool = false

    init(expenseRepository: ExpenseRepositoryType) {
        self.expenseRepository = expenseRepository
    }
    
}
