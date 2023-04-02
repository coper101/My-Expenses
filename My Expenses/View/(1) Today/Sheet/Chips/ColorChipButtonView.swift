//
//  ColorChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct ColorChipButtonView: View {
    // MARK: - Props
    var isActive: Bool
    var color: Color
    var action: Action
    
    // MARK: - UI
    var body: some View {
        CircleChipButtonView(
            isActive: isActive,
            action: action
        ) {
            Circle()
                .fill(color)
                .frame(width: 35, height: 35)
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct ColorChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorChipButtonView(
            isActive: true,
            color: .green,
            action: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
