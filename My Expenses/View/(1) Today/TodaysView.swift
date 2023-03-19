//
//  Todays.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct TodaysView: View {
    // MARK: - Props
    private let viewModel: TodaysViewModel
    
    init(expenseRepository: ExpenseRepositoryType) {
        self.viewModel = .init(expenseRepository: expenseRepository)
    }

    // MARK: - UI
    var body: some View {
        VStack(spacing: 40) {

            // Row 1: CONTENT
            VStack(alignment: .leading, spacing: 11) {

                // TITLE
                Text("Today's Expenses")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.2,
                        fontWeight: .semibold,
                        size: 24
                    )

                // EXPENSES
                if let todaysExpense = viewModel.todaysExpense {
                    ForEach(todaysExpense.items, id: \.date) {
                        ExpenseRowView(expense: $0)
                    }
                }
                
                // TOTAL PRICE
                HStack(alignment: .bottom, spacing: 12) {

                    // TITLE
                    Text("Total")
                        .textStyle(
                            foregroundColor: .black,
                            fontWeight: .semibold,
                            size: 18
                        )

                    // GUIDE LINE
                    GeometryReader { geometry in

                        let width = geometry.size.width

                        HStack(spacing: 5) {

                            ForEach(1..<Int(width / 6.5), id: \.self) { _ in

                                Circle()
                                    .fill(Color.black.opacity(0.2))
                                    .frame(width: 2, height: 2)

                            } //: ForEach

                        } //: HStack

                    } //: GeometryReader
                    .frame(height: 2)
                    .padding(.bottom, 4)

                    // PRICE
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

            // Row 2: INPUT
            HStack(spacing: 0) {
                TextField("Enter Item . . .", text: .constant(""))
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.2,
                        fontWeight: .semibold,
                        size: 15
                    )
                Spacer()
                Text("Scribble")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.1,
                        fontWeight: .semibold,
                        size: 15
                    )
            } //: HStack

        } //: VStack
        .padding(.top, 32)
        .padding(.bottom, 18)
        .padding(.horizontal, 24)
        .background(Color.gray.opacity(0.2))
        .padding(.horizontal, 21)
        .padding(.top, 8)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct TodaysExpenses_Previews: PreviewProvider {
    static var previews: some View {
        TodaysView(expenseRepository: TestData.repository)
            .previewLayout(.sizeThatFits)
            .background(Color.white)
    }
}
