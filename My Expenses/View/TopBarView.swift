//
//  TopBarView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

struct TopBarItem {
    var title: String
    var isActive: Bool
    var action: Action
}

struct TopBarView: View {
    // MARK: - Props
    @Environment(\.dimensions) var dimensions
    var leading: TopBarItem
    var trailing: TopBarItem
    var backgroundColor: Color = .white
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 10) {
            
            NavBarItemView(
                title: leading.title,
                isActive: leading.isActive,
                action: leading.action
            )
            
            Spacer()
            
            NavBarItemView(
                title: trailing.title,
                isActive: trailing.isActive,
                action: trailing.action
            )
            
        } //: HStack
        .padding(.horizontal, 21)
        .frame(height: dimensions.topBarHeight)
        .padding(.top, dimensions.insets.top)
        .background(backgroundColor)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(
            leading: .init(
                title: "Edit",
                isActive: false,
                action: {}
            ),
            trailing: .init(
                title: "Customize",
                isActive: false,
                action: {}
            )
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.green)
        .previewDisplayName("Normal")
        
        TopBarView(
            leading: .init(
                title: "Edit",
                isActive: true,
                action: {}
            ),
            trailing: .init(
                title: "Customize",
                isActive: true,
                action: {}
            )
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
