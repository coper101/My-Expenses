//
//  My_ExpensesApp.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

@main
struct My_ExpensesApp: App {
    @StateObject var expenseRepository = ExpenseRepository()

    var body: some Scene {
        WindowGroup {
            AppView(expenseRepository: expenseRepository)
                .preferredColorScheme(.light)
        }
    }
}
