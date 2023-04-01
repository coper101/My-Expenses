//
//  TopBarView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

struct TopBarView: View {
    // MARK: - Props
    var isEditing: Bool
    var isCustomizing: Bool
    var editAction: Action
    var customizeAction: Action
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 10) {
            
            NavBarItemView(
                title: "Edit",
                isActive: isEditing,
                action: editAction
            )
            
            Spacer()
            
            NavBarItemView(
                title: "Customize",
                isActive: isCustomizing,
                action: customizeAction
            )
            
        } //: HStack
        .padding(.horizontal, 21)
        .frame(height: 49)
        .background(Color.white)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(
            isEditing: false,
            isCustomizing: false,
            editAction: {},
            customizeAction: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.green)
        .previewDisplayName("Normal")
        
        TopBarView(
            isEditing: true,
            isCustomizing: true,
            editAction: {},
            customizeAction: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.green)
        .previewDisplayName("Editing and Customizing")
    }
}

struct NavBarItemView: View {
    // MARK: - Props
    var title: String
    var isActive: Bool
    var action: () -> Void
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            Text(isActive ? "Done" : title)
                .textStyle(
                    foregroundColor: isActive ? .secondary : .black,
                    colorOpacity: isActive ? 1 : 0.2,
                    fontWeight: .semibold,
                    size: 18
                )
        } //: Button
    }
}
