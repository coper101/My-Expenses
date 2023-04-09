//
//  BackgroundOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct BackgroundOptionsView: View {
    // MARK: - Props
    @Binding var backgroundUsed: BackgroundUsed
    @Binding var selectedColor: Color
    @Binding var selectedImage: UIImage?
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // MARK: - Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "COLOR")
                
                ScrollView {
                    HStack(spacing: 26) {
                        NoColorChipButtonView(isActive: backgroundUsed == .image || selectedColor == .white) {
                            selectedColor = .white
                        }
                        CircleChipButtonView(
                            isActive: backgroundUsed != .image && selectedColor != .white,
                            action: nil
                        ) {
                            ColorPicker("Color Picker", selection: $selectedColor)
                                .labelsHidden()
                        }
                    }
                } //: ScrollView
                .frame(height: 47)
            }
            
            // MARK: - Background Image
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "IMAGE")
                
                ScrollView {
                    HStack(spacing: 26) {
                        HStack(spacing: 26) {
                            AddImageChipButtonView(action: {})
                            ImageChipButtonView(
                                isActive: true,
                                action: {},
                                image: UIImage(named: Icons.backgroundImage1.rawValue)!
                            )
                        }
                    }
                } //: ScrollView
                .frame(height: 82)
            }
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct BackgroundOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundOptionsView(
            backgroundUsed: .constant(.color),
            selectedColor: .constant(.white),
            selectedImage: .constant(nil)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
