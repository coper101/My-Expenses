//
//  WeekView.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct WeekView: View {
    // MARK: - Props
    private let viewModel: WeekViewModel
    
    init(expenseRepository: ExpenseRepositoryType) {
        self.viewModel = .init(expenseRepository: expenseRepository)
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
    static var previews: some View {
        WeekView(expenseRepository: TestData.repository)
            .previewLayout(.sizeThatFits)
    }
}
