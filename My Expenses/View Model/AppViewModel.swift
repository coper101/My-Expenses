//
//  AppViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Combine
import SwiftUI

enum BackgroundUsed {
    case color
    case image
}

final class AppViewModel: ObservableObject {
        
    // MARK: Data
    @Published var weekExpenses: [WeekExpense] = []
    
    // MARK: UI
    @Published var selectedTab: TabItem = .today
    @Published var isNewItemFocused: Bool = false
    @Published var isEditing: Bool = false
    @Published var isCustomizing: Bool = false
    
    @Published var selectedBackgroundColor: Color = .white
    @Published var selectedBackgroundImage: UIImage?
    
    @Published var backgroundUsed: BackgroundUsed = .color
    
}
