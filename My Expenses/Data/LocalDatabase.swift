//
//  LocalDatabase.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Foundation
import CoreData
import OSLog

// MARK: Identifiers
enum Containers: String {
    case myExpenses = "My_Expenses"
    var name: String {
        return self.rawValue
    }
}

// MARK: Types
enum Entities: String {
    case expense = "Expense"
    var name: String {
        return self.rawValue
    }
}

enum StorageType {
    case sql
    case memory
}

extension NSManagedObjectContext {

    /// Only performs a save if there are changes to commit.
    /// - Returns: `true` if a save was needed. Otherwise, `false`.
    @discardableResult public func saveIfNeeded() throws -> Bool {
        guard hasChanges else { return false }
        try save()
        return true
    }
}

// MARK: - Protocol
protocol Database {
    var container: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }
    
    init(container: Containers)
    
    func loadContainer(
        onError: @escaping (Error) -> Void,
        onSuccess: @escaping () -> Void
    ) -> Void
}

extension Database {
    func loadContainer(
        onError: @escaping (Error) -> Void,
        onSuccess: @escaping () -> Void
    ) {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                Logger.database.debug("loadPersistentStores error: \(error.localizedDescription)")
                onError(error); return
            }
            Logger.database.debug("loadPersistentStores loaded")
            onSuccess(); return
        }
    }
}

// MARK: - App Implementation
class LocalDatabase: Database {

    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    required init(container: Containers) {
        self.container = NSPersistentContainer(name: container.name)
        Logger.database.debug("container persistent descriptions: \(self.container.persistentStoreDescriptions)")
    }
    
}

// MARK: - Test Implementation
class InMemoryLocalDatabase: Database {

    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    required init(container: Containers) {
        self.container = NSPersistentContainer(name: container.name)
        if let storeDescription = self.container.persistentStoreDescriptions.first {
            // storeDescription.type = NSInMemoryStoreType
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        Logger.database.debug("container persistent descriptions: \(self.container.persistentStoreDescriptions)")
    }
    
}

