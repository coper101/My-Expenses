//
//  TextOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 4/5/23.
//

import SwiftUI

struct TextOptionsView: View {
    // MARK: - Props

    /// Font Color
    @State private var selectedPickerFontColor: Color = .clear
    @Binding var selectedFontColor: Color
    var fontColorSelection: [ColorSelection]
    var selectedFontColorAction: SelectAction
    var pickFontColorAction: (Color) -> Void
    
    /// Font Size
    @Binding var fontSize: Double
    
    /// Font
    @Binding var selectedFont: Fonts
    var fontSelection: [FontSelection]
    var selectedFontAction: SelectAction
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // MARK: Sheet Font Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "SHEET FONT COLOR")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 26) {
                        
                        // Color Picker
                        ColorPicker(
                            "Background Color Picker",
                            selection: $selectedPickerFontColor
                        )
                        .labelsHidden()
                        
                        // Colors
                        ForEach(fontColorSelection, id: \.date) { selection in
                            ColorChipButtonView(
                                isActive: selection.isSelected,
                                color: selection.color,
                                action: { selectedFontColorAction(selection.date) }
                            )
                        }
                    } //: HStack
                    
                } //: ScrollView
                .frame(height: 47)
            } //: VStack
            
            // MARK: Sheet Font Size
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "SHEET FONT SIZE")
                
                HStack(spacing: 23) {
                    Slider(value: $fontSize, in: 12...28)
                        .accentColor(Color.secondaryColor)
                    Text(fontSize.formatTo(dp: 0))
                        .textStyle(
                            foregroundColor: .black,
                            size: 26
                        )
                        .frame(width: 34)
                }
            } //: VStack
            
            // MARK: Sheet Font
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "SHEET FONT")
                
                ScrollView(.horizontal, showsIndicators: false) {
                        
                    HStack(spacing: 26) {
                        ForEach(fontSelection, id: \.date) { selection in
                            RectangularChipButtonView(
                                isActive: selection.isSelected,
                                action: { selectedFontAction(selection.date) },
                                fillBackground: false
                            ) {
                                Text("ABC")
                                    .textStyle(
                                        foregroundColor: .black,
                                        font: selection.font,
                                        size: 26
                                    )
                                    .fillMaxSize()
                                    .background(Color.sheetGray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(10)
                            }
                        }
                    } //: HStack
                        
                } //: ScrollView
                .frame(height: 82)

            } //: VStack
        }
        .padding(.bottom, Dimensions.theInsets.bottom)
        .onChange(of: selectedPickerFontColor, perform: onChangePickerFontColor)
    }
    
    // MARK: - Actions
    func onChangePickerFontColor(color: Color) {
        guard let cgColor = color.cgColor, let colorComponents = cgColor.components else {
            return
        }
        pickFontColorAction(.init(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2]))
    }
}

// MARK: - Preview
struct TextOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TextOptionsView(
            /// Font Color
            selectedFontColor: .constant(.gray),
            fontColorSelection: [
                .init(date: .init(), color: .gray, isSelected: true)
            ],
            selectedFontColorAction: { _ in },
            pickFontColorAction: { _ in },
            /// Font Size
            fontSize: .constant(14),
            /// Font
            selectedFont: .constant(.sfProTextSemibold),
            fontSelection: [
                .init(date: .init(), font: .sfProTextSemibold, isSelected: true)
            ],
            selectedFontAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
