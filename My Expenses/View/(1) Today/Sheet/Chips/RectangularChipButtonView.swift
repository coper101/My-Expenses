//
//  RectangularChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 9/4/23.
//

import SwiftUI

struct RectangularChipButtonView<Content>: View where Content: View {
    // MARK: - Props
    var isActive: Bool
    var action: Action
    var fillBackground: Bool = false
    @ViewBuilder var content: Content
    
    
    // MARK: - UI
    var shape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 15)
    }
    
    let color = Color.black.opacity(0.04)
    
    var body: some View {
        Button(action: action) {
            ZStack {
                
                // MARK: Active
                if fillBackground {
                    shape
                        .fill(color)
                        .fillMaxSize()
                } else {
                    shape
                        .strokeBorder(lineWidth: 3, antialiased: true)
                        .foregroundColor(isActive ? Color.blue : color)
                        .fillMaxSize()
                }
                
                // MARK: Content
                content
                
            } //: ZStack
            .clipShape(shape)

        } //: Button
        .frame(width: 118, height: 82)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct RectangularChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RectangularChipButtonView(
            isActive: true,
            action: {}
        ) {
            Icons.backgroundImage1.image
                .resizable()
                .scaledToFill()
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Active")
        
        RectangularChipButtonView(
            isActive: false,
            action: {}
        ) {
            Icons.backgroundImage2.image
                .resizable()
                .scaledToFill()
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Inactive")
        
        RectangularChipButtonView(
            isActive: false,
            action: {},
            fillBackground: true
        ) {
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .previewDisplayName("Fill Background")
    }
}
