//
//  BackgroundOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

typealias SelectAction = (Date) -> Void

struct BackgroundOptionsView: View {
    // MARK: - Props
    @Binding var backgroundUsed: BackgroundUsed
    
    /// Color
    @State private var selectedPickerColor: Color = .clear
    @Binding var selectedColor: Color
    var colorSelection: [ColorSelection]
    var selectedColorAction: SelectAction
    var pickColorAction: (Color) -> Void
    
    /// Image
    @Binding var selectedImage: UIImage?
    var imagesSelection: [ImageSelection]
    var pickImageAction: Action
    var selectedImageAction: SelectAction
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // MARK: - Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "COLOR")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 26) {
                        NoColorChipButtonView(
                            isActive: backgroundUsed == .image || colorSelection.isEmpty || selectedColor == .clear
                        ) {
                            selectedColor = .clear
                        }
                        ColorPicker("Color Picker", selection: $selectedPickerColor)
                            .labelsHidden()
                        ForEach(colorSelection, id: \.date) { selection in
                            ColorChipButtonView(
                                isActive: selection.isSelected && backgroundUsed == .color && selectedColor != .clear,
                                color: selection.color,
                                action: { selectedColorAction(selection.date) }
                            )
                        }
                    } //: HStack
                    
                } //: ScrollView
                .frame(height: 47)
            }
            
            // MARK: - Background Image
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "IMAGE")
                
                ScrollView(.horizontal, showsIndicators: false) {
                        
                    HStack(spacing: 26) {
                        AddImageChipButtonView(action: pickImageAction)
                        ForEach(imagesSelection, id: \.date) { selection in
                            ImageChipButtonView(
                                isActive: selection.isSelected && backgroundUsed == .image,
                                action: { selectedImageAction(selection.date) },
                                image: selection.image
                            )
                        }
                    } //: HStack
                        
                } //: ScrollView
                .frame(height: 82)
            }
        }
        .onChange(of: selectedPickerColor, perform: onChangePickerColor)
    }
    
    // MARK: - Actions
    func onChangePickerColor(color: Color) {
        guard let cgColor = color.cgColor, let colorComponents = cgColor.components else {
            return
        }
        pickColorAction(.init(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2]))
    }
}

// MARK: - Preview
struct BackgroundOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundOptionsView(
            backgroundUsed: .constant(.color),
            selectedColor: .constant(.white),
            colorSelection: [
                .init(date: .init(), color: .red, isSelected: true),
                .init(date: .init(), color: .blue, isSelected: false)
            ],
            selectedColorAction: { _ in },
            pickColorAction: { _ in },
            selectedImage: .constant(nil),
            imagesSelection: [
                .init(
                    date: .init(),
                    image: .init(named: Icons.backgroundImage1.rawValue)!,
                    isSelected: true
                )
            ],
            pickImageAction: {},
            selectedImageAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
