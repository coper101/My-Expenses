//
//  WeekView.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct WeekExpense {
    let dateInterval: DateInterval
    let dayExpenses: [DayExpense]
}

struct WeekView: View {
    // MARK: - Props
    @EnvironmentObject var appViewModel: AppViewModel
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 45) {
            
            ForEach(appViewModel.weekExpenses, id: \.dateInterval) { weekExpense in
                WeekExpensesView(
                    monthAndWeekFormat: "Feb, Week 1",
                    dayExpenses: weekExpense.dayExpenses
                )
            }
           
        } //: VStack
        .padding(.horizontal, 28)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
            .previewLayout(.sizeThatFits)
            .environmentObject(AppViewModel())
    }
}
