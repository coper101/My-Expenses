//
//  My_ExpensesApp.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

@main
struct My_ExpensesApp: App {
    @StateObject var appViewModel: AppViewModel = .init()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(appViewModel)
        }
    }
}
