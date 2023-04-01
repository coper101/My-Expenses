//
//  Todays.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct TodaysView: View {
    // MARK: - Props
    @ObservedObject var appViewModel: AppViewModel
    @StateObject private var viewModel: TodaysViewModel
    
    init(
        expenseRepository: ExpenseRepositoryType,
        appViewModel: AppViewModel
    ) {
        self._viewModel = .init(wrappedValue: .init(expenseRepository: expenseRepository))
        self.appViewModel = appViewModel
    }

    // MARK: - UI
    var content: some View {
        VStack(alignment: .leading, spacing: 11) {

            // MARK: Title
            Text("Today's Expenses")
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    fontWeight: .semibold,
                    size: 24
                )

            // MARK: Expenses
            if let todaysExpense = viewModel.todaysExpense {
                ForEach(todaysExpense.items, id: \.date) {
                    ExpenseRowView(
                        expense: $0,
                        isEditing: appViewModel.isEditing,
                        deleteAction: viewModel.didTapDeleteExpense
                    )
                }
            }
            
            // MARK: Total Price
            HStack(alignment: .bottom, spacing: 12) {

                // MARK: Title
                Text("Total")
                    .textStyle(
                        foregroundColor: .black,
                        fontWeight: .semibold,
                        size: 18
                    )

                // MARK: Guide Line
                GuideLineView()
                    .frame(height: 2)
                    .padding(.bottom, 4)

                // MARK: Price
                Text(viewModel.totalPrice)
                    .textStyle(
                        foregroundColor: .black,
                        fontWeight: .semibold,
                        size: 14
                    )

            } //: HStack
            .padding(.trailing, 14)
            .padding(.leading, 38 + 14)
            .padding(.top, 40 - 12)

        } //: VStack
    }
    
    var body: some View {
        VStack(spacing: 40) {
            
            // MARK: Content
            content
            
            // MARK: Input
            InputNavigatorView(
                enterItemAction: enterItemAction,
                scribbleAction: scribbleAction
            )
            
        } //: VStack
        .padding(.top, 32)
        .padding(.bottom, 18)
        .padding(.horizontal, 24)
        .background(Color.gray.opacity(0.2))
        .padding(.horizontal, 21)
        .padding(.top, 8)
    }
    
    // MARK: - Actions
    func enterItemAction() {
        appViewModel.isNewItemFocused = true
    }
    
    func scribbleAction() {
        
    }
}

// MARK: - Preview
struct TodaysExpenses_Previews: PreviewProvider {
    static var expenseRepo: ExpenseRepository = TestData.repository
    
    static var previews: some View {
        TodaysView(
            expenseRepository: expenseRepo,
            appViewModel: .init(expenseRepository: expenseRepo)
        )
        .previewLayout(.sizeThatFits)
        .background(Color.white)
    }
}
