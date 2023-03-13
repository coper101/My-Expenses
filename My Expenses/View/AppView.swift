//
//  AppView.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct AppView: View {
    // MARK: - Props
    @EnvironmentObject var appViewModel: AppViewModel
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Bar
            TopBarView(
                editAction: {},
                customizeAction: {}
            )
            
            // MARK: Content
            ScrollView(.vertical, showsIndicators: false) {
                
                switch (appViewModel.selectedTab) {
                case .today:
                    TodaysView()
                case .week:
                    WeekView()
                } //: switch-case
                
            } //: ScrollView
            .fillMaxSize()
            
            // MARK: Bottom Bar
            BottomBarView(selectedTab: $appViewModel.selectedTab)
            
        } //: VStack
        .fillMaxSize()
        .background(Color.white)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .previewLayout(.sizeThatFits)
            .environmentObject(AppViewModel())
    }
}
