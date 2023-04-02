//
//  NoColorChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct NoColorChipButtonView: View {
    // MARK: - Props
    var isActive: Bool
    var action: Action
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            Icons.noSign.image
                .resizable()
                .frame(width: 47, height: 47)
                .foregroundColor(isActive ? Color.blue : Color.black.opacity(0.05))
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct NoColorChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NoColorChipButtonView(
            isActive: true,
            action: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Active")
        
        NoColorChipButtonView(
            isActive: false,
            action: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Inactive")
    }
}
