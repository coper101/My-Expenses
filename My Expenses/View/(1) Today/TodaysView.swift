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
    var fontSize: CGFloat {
        .init(appViewModel.fontSize)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 11) {

            // MARK: Title
            Text("Today's Expenses")
                .textStyle(
                    foregroundColor: appViewModel.selectedFontColor,
                    colorOpacity: 0.2,
                    font: appViewModel.selectedFont,
                    size: 24
                )

            // MARK: Expenses
            if let todaysExpense = viewModel.todaysExpense {
                ForEach(todaysExpense.items, id: \.date) {
                    ExpenseRowView(
                        expense: $0,
                        isEditing: appViewModel.isEditing,
                        fontSize: fontSize,
                        fontColor: appViewModel.selectedFontColor,
                        font: appViewModel.selectedFont,
                        deleteAction: viewModel.didTapDeleteExpense
                    )
                    .background(appViewModel.selectedSheetItemBackgroundColor)
                }
            }
            
            // MARK: Total Price
            HStack(alignment: .bottom, spacing: 12) {

                // MARK: Title
                Text("Total")
                    .textStyle(
                        foregroundColor: appViewModel.selectedFontColor,
                        font: appViewModel.selectedFont,
                        size: fontSize
                    )

                // MARK: Guide Line
                GuideLineView()
                    .frame(height: 2)
                    .padding(.bottom, 4)

                // MARK: Price
                Text(viewModel.totalPrice)
                    .textStyle(
                        foregroundColor: appViewModel.selectedFontColor,
                        font: appViewModel.selectedFont,
                        size: fontSize - 4
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
                font: appViewModel.selectedFont,
                enterItemAction: enterItemAction,
                scribbleAction: scribbleAction
            )
            
        } //: VStack
        .padding(.top, 32)
        .padding(.bottom, 18)
        .padding(.horizontal, 24)
        .background(appViewModel.selectedSheetBackgroundColor)
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
            appViewModel: .init()
        )
        .previewLayout(.sizeThatFits)
        .background(Color.white)
    }
}
