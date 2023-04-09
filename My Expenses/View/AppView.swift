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
        self._appViewModel = .init(wrappedValue: .init())
    }
    
    // MARK: - UI
    var body: some View {
        ZStack(alignment: .bottom) {
            
            // MARK: Content
            VStack(spacing: 0) {
                
                // MARK: Top Bar
                TopBarView(
                    leading: .init(
                        title: "Edit",
                        isActive: appViewModel.isEditing,
                        action: editAction
                    ),
                    trailing: .init(
                        title: "Customize",
                        isActive: appViewModel.isCustomizing,
                        action: customizeAction
                    )
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
                        WeekView(
                            expenseRepository: expenseRepository,
                            appViewModel: appViewModel
                        )
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
            .zIndex(0)
            
            // MARK: Sheet
            if appViewModel.isCustomizing {
                
                CustomizeSheetView(closeAction: closeSheetAction)
                    .environmentObject(appViewModel)
                    .transition(.move(edge: .bottom))
                    .animation(.easeOut(duration: 0.4), value: appViewModel.isCustomizing)
                    .zIndex(1)
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -2)
            } //: if
        }
        .background(appViewModel.backgroundUsed == .color ? appViewModel.selectedBackgroundColor : Color.white)
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
    
    func editAction() {
        withAnimation {
            appViewModel.isEditing.toggle()
        }
    }
    
    func customizeAction() {
        withAnimation {
            appViewModel.isCustomizing.toggle()
        }
    }
    
    func closeSheetAction() {
        withAnimation {
            appViewModel.isCustomizing = false
        }
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
