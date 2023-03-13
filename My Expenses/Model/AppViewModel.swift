//
//  AppViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Combine

final class AppViewModel: ObservableObject {
    
    let expenseRepository: ExpenseType
    
    // MARK: Data
    @Published var weekExpenses: [WeekExpense] = TestData.sampleWeekExpenses
    
    // MARK: UI
    @Published var selectedTab: TabItem = .today

    init(
        expenseRepository: ExpenseType = ExpenseRepository()
    ) {
        self.expenseRepository = expenseRepository
    }
    
    
    
}
