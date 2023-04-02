//
//  BackgroundOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct BackgroundOptionsView: View {
    // MARK: - Props
    @State var hasSelectedColorOption: Bool = false
    @State var selectedColor: Color?
    
    @State var hasSelectedImageOption: Bool = false
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // MARK: - Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "COLOR")
                
                ScrollView {
                    HStack(spacing: 26) {
                        NoColorChipButtonView(
                            isActive: !hasSelectedColorOption,
                            action: {
                                hasSelectedColorOption = false
                            }
                        )
                        ColorPickerChipButtonView(
                            isActive: hasSelectedColorOption,
                            action: {
                                hasSelectedColorOption = true
                            }
                        )
                    }
                } //: ScrollView
                .frame(height: 47)
            }
            
            // MARK: - Background Image
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "IMAGE")
                
                ScrollView {
                    HStack(spacing: 26) {
                        
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
        BackgroundOptionsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
