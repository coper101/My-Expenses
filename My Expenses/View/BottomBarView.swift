//
//  BottomBarView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

enum TabItem: String {
    case today = "Today"
    case week = "Week"
    var title: String {
        self.rawValue
    }
}

struct BottomBarView: View {
    // MARK: - Props
    @Binding var selectedTab: TabItem
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 20) {
            
            TabItemview(
                title: "Today",
                isSelected: selectedTab == .today
            ) {
                selectedTab = .today
            }
            
            TabItemview(
                title: "Week",
                isSelected: selectedTab == .week
            ) {
                selectedTab = .week
            }
            
        } //: HStack
        .padding(.horizontal, 21)
        .padding(.vertical, 16)
        .fillMaxWidth()
        .background(Color.white)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        BottomBarView(selectedTab: .constant(.today))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
            .previewDisplayName("Today Selected")
        
        BottomBarView(selectedTab: .constant(.week))
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
            .previewDisplayName("Week Selected")
    }
}

struct TabItemview: View {
    // MARK: - Props
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            
            VStack(spacing: 6) {
                
                Text(title)
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: isSelected ? 1 : 0.1,
                        fontWeight: .semibold,
                        size: 18
                    )
                
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(height: 5)
                    .fillMaxWidth()
                    .opacity(isSelected ? 1 : 0)
                
            } //: VStack
            .fixedSize(horizontal: true, vertical: false)
            
        } //: Button
    }
}
