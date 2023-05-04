//
//  WeekItemsView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

struct WeekExpensesViewModel {
    
    let weekExpense: WeekExpense
    
    init(_ weekExpense: WeekExpense) {
        self.weekExpense = weekExpense
    }
    
    var dayExpenses: [DayExpense] {
        weekExpense.dayExpenses
            .sorted(by: { $0.date < $1.date })
    }
    
    var header: String {
        "Week"
    }
}

struct WeekExpensesView: View {
    // MARK: - Props
    private let viewModel: WeekExpensesViewModel
    
    init(weekExpense: WeekExpense) {
        self.viewModel = .init(weekExpense)
    }
    
    let spaceInBetween: CGFloat = 14
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: Header
            Text(viewModel.header)
                .textStyle(
                    foregroundColor: .black,
                    font: .sfProTextSemibold,
                    size: 24
                )
                .fillMaxWidth(alignment: .leading)
            
            // MARK: Weeks
            GeometryReader { geometry in
                
                let itemWidth = (geometry.size.width - (spaceInBetween * 2)) / 3
                
                LazyVGrid(
                    columns:
                        Array(
                            repeating: GridItem(.fixed(itemWidth), spacing: spaceInBetween),
                            count: 3
                        ),
                    spacing: spaceInBetween
                ) {
                    ForEach(viewModel.dayExpenses, id: \.date) {
                        DayExpenseBoxView(
                            dayExpense: $0,
                            width: itemWidth
                        )
                    }
                }
            } //: GeometryReader
            .frame(height: itemsHeight)
            
        } //: VStack
    }
    
    // MARK: - Actions
    var itemsHeight: CGFloat {
        let itemsHeight = UIScreen.main.bounds.width / 3
        let itemsCount = CGFloat(viewModel.dayExpenses.count)
        if (itemsCount > 5) {
            return 3 * itemsHeight
        } else if (itemsCount > 3) {
            return 2 * itemsHeight
        } else {
            return itemsHeight
        }
    }
}

// MARK: - Preview
struct WeekExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        WeekExpensesView(
            weekExpense: TestData.weekViewModel.weekExpenses.first ?? TestData.sampleWeekExpenseEmpty
        )
        .previewLayout(.sizeThatFits)
        .background(Color.white)
        .padding()
    }
}
