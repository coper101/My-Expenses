//
//  ColorPickerChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct ColorPickerChipButtonView: View {
    // MARK: - Props
    var isActive: Bool
    var action: Action
    
    // MARK: - UI
    var body: some View {
        CircleChipButtonView(
            isActive: isActive,
            action: action
        ) {
            ZStack {
                
                // MARK: Gradient
                Circle()
                    .fill(
                        AngularGradient(
                            colors: [
                                Color(red: 111/255, green: 203/255, blue: 203/255),
                                Color(red: 144/255, green: 229/255, blue: 103/255),
                                Color(red: 229/255, green: 213/255, blue: 89/255),
                                Color(red: 215/255, green: 94/255, blue: 82/255),
                                Color(red: 117/255, green: 90/255, blue: 205/255),
                                Color(red: 105/255, green: 109/255, blue: 223/255)
                            ],
                            center: .center,
                            angle: .init(degrees: 140)
                        )
                    )
                    .frame(width: 35, height: 35)
                
                // MARK: Center
                Circle()
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                
            } //: ZStack
        } //: CircleChipButtonView
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct ColorPickerChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerChipButtonView(isActive: true, action: {})
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Color Picker Chip")
    }
}
