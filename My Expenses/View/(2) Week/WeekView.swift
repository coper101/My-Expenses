//
//  WeekView.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct WeekView: View {
    // MARK: - Props
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var viewModel: WeekViewModel
    
    init(
        expenseRepository: ExpenseRepositoryType,
        appViewModel: AppViewModel
    ) {
        self._viewModel = .init(wrappedValue: .init(expenseRepository: expenseRepository))
        self.appViewModel = appViewModel
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 45) {
            
            ForEach(viewModel.weekExpenses, id: \.dateInterval) {
                WeekExpensesView(weekExpense: $0)
            }
           
        } //: VStack
        .padding(.horizontal, 28)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct WeekView_Previews: PreviewProvider {
    static var expenseRepo: ExpenseRepository = TestData.repository

    static var previews: some View {
        WeekView(
            expenseRepository: expenseRepo,
            appViewModel: .init()
        )
        .previewLayout(.sizeThatFits)
    }
}
