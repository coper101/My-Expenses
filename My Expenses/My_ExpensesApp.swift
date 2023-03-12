//
//  My_ExpensesApp.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

@main
struct My_ExpensesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
