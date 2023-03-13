//
//  TopBarView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

struct TopBarView: View {
    // MARK: - Props
    var editAction: () -> Void
    var customizeAction: () -> Void
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 10) {
            
            NavBarItemView(
                title: "Edit",
                action: editAction
            )
            
            Spacer()
            
            NavBarItemView(
                title: "Customize",
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
            editAction: {},
            customizeAction: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.green)
    }
}

struct NavBarItemView: View {
    // MARK: - Props
    var title: String
    var action: () -> Void
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            Text(title)
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    fontWeight: .semibold,
                    size: 18
                )
        } //: Button
    }
}
