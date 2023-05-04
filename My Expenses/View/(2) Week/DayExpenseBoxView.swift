//
//  DayExpenseBoxView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

enum Day: Int {
    case sun, mon, tue, wed, thu, fri, sat
    
    var name: String {
        switch self {
        case .sun:
            return "Sun"
        case .mon:
            return "Mon"
        case .tue:
            return "Tue"
        case .wed:
            return "Wed"
        case .thu:
            return "Thu"
        case .fri:
            return "Fri"
        case .sat:
            return "Sat"
        }
    }
}

struct DayExpenseViewModel {
    let dayExpense: DayExpense
    
    init(_ dayExpense: DayExpense) {
        self.dayExpense = dayExpense
    }
    
    var shortWeekdayName: String {
        let weekday = dayExpense.date.getWeekday()
        let day = Day(rawValue: weekday) ?? .sun
        return day.name
    }
    
    var numberOfItems: String {
        "\(dayExpense.items.count) Items"
    }
    
    var totalPrice: String {
        getTotalPrice(items: dayExpense.items)
    }
}

struct DayExpenseBoxView: View {
    // MARK: - Props
    private let viewModel: DayExpenseViewModel
    let width: CGFloat
    
    init(dayExpense: DayExpense, width: CGFloat) {
        self.viewModel = .init(dayExpense)
        self.width = width
    }
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            Text(viewModel.shortWeekdayName)
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    font: .sfProTextSemibold,
                    size: 18
                )
            
            Text(viewModel.totalPrice)
                .textStyle(
                    foregroundColor: .black,
                    font: .sfProTextSemibold,
                    size: 18
                )
            
            Text(viewModel.numberOfItems)
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    font: .sfProTextSemibold,
                    size: 12
                )
            
        } //: VStack
        .padding(.leading, 18)
        .fillMaxWidth(alignment: .leading)
        .frame(height: width)
        .background(Color.black.opacity(0.05))
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct DayExpenseBoxView_Previews: PreviewProvider {
    static var previews: some View {
        DayExpenseBoxView(
            dayExpense: TestData.sampleDayExpense,
            width: 102
        )
        .previewLayout(.sizeThatFits)
        .frame(width: 102)
        .background(Color.white)
        .padding()
    }
}
