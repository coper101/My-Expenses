//
//  WeekItemsView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

struct DayExpense {
    let date: Date
    let items: [Expense]
    
    var day: Day {
        Day(rawValue: date.getWeekday()) ?? .sun
    }
    
    var displayedCount: String {
        "\(items.count) Items"
    }
    
    var totalPrice: Double {
        items
            .map(\.price)
            .reduce(0) { $0 + $1 }
    }
    
}

struct WeekExpensesView: View {
    // MARK: - Props
    var monthAndWeekFormat: String
    var dayExpenses: [DayExpense]
    
    var sortedDayExpenses: [DayExpense] {
        dayExpenses.sorted(by: { $0.date > $1.date })
    }
    
    let spaceInBetween: CGFloat = 14
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 20) {
            
            // HEADER
            Text(monthAndWeekFormat)
                .textStyle(
                    foregroundColor: .black,
                    fontWeight: .semibold,
                    size: 24
                )
                .fillMaxWidth(alignment: .leading)
            
            // ITEMS
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
                    ForEach(sortedDayExpenses, id: \.date) { dayExpense in
                        DayExpenseBoxView(
                            width: itemWidth,
                            day: dayExpense.day,
                            price: dayExpense.totalPrice,
                            itemsCount: dayExpense.items.count
                        )
                    } //: ForEach
                }
            } //: GeometryReader
            .frame(height: itemsHeight)
            
        } //: VStack
    }
    
    // MARK: - Actions
    var itemsHeight: CGFloat {
        let itemsHeight = UIScreen.main.bounds.width / 3
        let itemsCount = CGFloat(dayExpenses.count)
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
            monthAndWeekFormat: "Feb, Week 1",
            dayExpenses: TestData.sampleDayExpenses
        )
        .previewLayout(.sizeThatFits)
        .background(Color.white)
        .padding()
        .background(Color.green)
    }
}
