//
//  ExpenseRowView.swift
//  My Expenses
//
//  Created by Wind Versi on 19/3/23.
//

import SwiftUI

struct ExpenseViewModel {
    
    let expense: ExpenseType
    
    init(_ expense: ExpenseType) {
        self.expense = expense
    }
    
    var time: String {
        expense.date?.toTimeFormat() ?? "00:00"
    }
    
    var name: String {
        expense.name ?? ""
    }
    
    var price: String {
        String(format: "%.2f", expense.price)
    }
}

struct ExpenseRowView: View {
    // MARK: - Props
    typealias DeleteAction = (ExpenseType) -> Void
    
    private let viewModel: ExpenseViewModel
    let isEditing: Bool
    let deleteAction: DeleteAction
    
    init(
        expense: ExpenseType,
        isEditing: Bool,
        deleteAction: @escaping DeleteAction
    ) {
        self.viewModel = .init(expense)
        self.isEditing = isEditing
        self.deleteAction = deleteAction
    }
    
    // MARK: - UI
    var body: some View {
        HStack(alignment: .bottom, spacing: 14) {

            // MARK: Time
            Group {
                if isEditing {
                    Button(action: { deleteAction(viewModel.expense) }) {
                        Icons.delete.image
                            .resizable()
                            .foregroundColor(.error)
                            .scaledToFit()
                            .frame(height: 30)
                    }
                } else {
                    Text(viewModel.time)
                        .textStyle(
                            foregroundColor: .black,
                            colorOpacity: 0.2,
                            fontWeight: .semibold,
                            size: 12
                        )
                        .padding(.bottom, 2)
                }
            }
            .frame(width: 38, alignment: .trailing)

            // MARK: Name
            Text(viewModel.name)
                .textStyle(
                    foregroundColor: .black,
                    fontWeight: .semibold,
                    size: 18
                )

            // MARK: Guide Line
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

            // MARK: Price
            Text(viewModel.price)
                .textStyle(
                    foregroundColor: .black,
                    fontWeight: .semibold,
                    size: 14
                )

        } //: HStack
        .padding(.vertical, 22)
        .padding(.leading, 4)
        .padding(.trailing, 15)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct ExpenseRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRowView(
            expense: TestData.sampleExpense,
            isEditing: false,
            deleteAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Normal")
        
        ExpenseRowView(
            expense: TestData.sampleExpense,
            isEditing: false,
            deleteAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Normal")
        
        ExpenseRowView(
            expense: TestData.sampleExpense,
            isEditing: true,
            deleteAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Editing")
    }
}
