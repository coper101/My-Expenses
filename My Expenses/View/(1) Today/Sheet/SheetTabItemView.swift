//
//  SheetTabItemView.swift
//  My Expenses
//
//  Created by Wind Versi on 1/4/23.
//

import SwiftUI

struct SheetTabItemView: View {
    // MARK: - Props
    var title: String
    var isActive: Bool
    var action: Action
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            Text(title)
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: isActive ? 1 : 0.15,
                    font: .sfProTextBold,
                    size: 24
                )
        } //: Button
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct SheetTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        SheetTabItemView(
            title: "Background",
            isActive: false,
            action: {}
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Inactive")
        .padding()
        
        SheetTabItemView(
            title: "Background",
            isActive: true,
            action: {}
        )
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Active")
        .padding()
    }
}
