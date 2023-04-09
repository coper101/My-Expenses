//
//  AddImageChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 9/4/23.
//

import SwiftUI

struct AddImageChipButtonView: View {
    // MARK: - Props
    var action: Action
    
    // MARK: - UI
    var body: some View {
        RectangularChipButtonView(
            isActive: false,
            action: action,
            fillBackground: true
        ) {
            Icons.plus.image
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(Color.black.opacity(1))
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct AddImageChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageChipButtonView(action: {})
            .previewLayout(.sizeThatFits)
    }
}
