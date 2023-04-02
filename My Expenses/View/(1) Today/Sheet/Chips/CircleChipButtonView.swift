//
//  CircleChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct CircleChipButtonView<Content>: View where Content: View {
    // MARK: - Props
    var isActive: Bool
    var action: Action
    @ViewBuilder var content: Content
    
    // MARK: - UI
    var body: some View {
        Button(action: action) {
            ZStack {
                
                // MARK: Active
                Circle()
                    .strokeBorder(lineWidth: 3, antialiased: true)
                    .foregroundColor(isActive ? Color.blue : Color.black.opacity(0.04))
                    .frame(width: 47, height: 47)
                
                // MARK: Content
                content
                
            } //: ZStack
        } //: Button
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct CircleChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CircleChipButtonView(isActive: false, action: {}) {}
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Inactive")
        
        CircleChipButtonView(isActive: false, action: {}) {}
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Active")
    }
}
