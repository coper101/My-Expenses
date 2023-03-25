//
//  AppView.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct AppView: View {
    // MARK: - Props
    @ObservedObject var expenseRepository: ExpenseRepository
    @StateObject var appViewModel: AppViewModel
    
    init(expenseRepository: ExpenseRepository) {
        self._expenseRepository = .init(wrappedValue: expenseRepository)
        self._appViewModel = .init(wrappedValue: .init(expenseRepository: expenseRepository))
    }
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Bar
            TopBarView(
                editAction: {},
                customizeAction: {}
            )
            
            // MARK: Content
            ScrollView(.vertical, showsIndicators: false) {
                
                switch (appViewModel.selectedTab) {
                case .today:
                    TodaysView(
                        expenseRepository: expenseRepository,
                        appViewModel: appViewModel
                    )
                case .week:
                    WeekView(expenseRepository: expenseRepository)
                } //: switch-case
                
            } //: ScrollView
            .fillMaxSize()
            
            // MARK: Bottom Bar
            if appViewModel.isNewItemFocused {
                NewItemInputView(
                    isFocused: $appViewModel.isNewItemFocused,
                    commitAction: newItemAction
                )
            } else {
                BottomBarView(selectedTab: $appViewModel.selectedTab)
            }
            
        } //: VStack
        .fillMaxSize()
        .background(Color.white)
    }
    
    // MARK: - Actions
    func newItemAction(name: String, price: String) {
        guard !name.isEmpty, let priceDb = Double(price) else {
            appViewModel.isNewItemFocused = false
            return
        }
        expenseRepository.add(date: .init(), name: name, price: priceDb)
        appViewModel.isNewItemFocused = false
    }
}

// MARK: - Preview
struct AppView_Previews: PreviewProvider {
    static var expenseRepo = TestData.repository
    
    static var previews: some View {
        AppView(expenseRepository: expenseRepo)
            .previewLayout(.sizeThatFits)
    }
}
