//
//  SheetOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 15/4/23.
//

import SwiftUI

struct SheetOptionsView: View {
    // MARK: - Props
    
    /// Background
    @State private var selectedPickerBgColor: Color = .clear
    @Binding var selectedBackgroundColor: Color
    var backgroundColorSelection: [ColorSelection]
    var selectedBackgroundColorAction: SelectAction
    var pickBackgroundColorAction: (Color) -> Void
    
    /// Item Background
    @State private var selectedPickerItemBgColor: Color = .clear
    @Binding var selectedItemBackgroundColor: Color
    var itemBackgroundColorSelection: [ColorSelection]
    var selectedItemBackgroundColorAction: SelectAction
    var pickItemBackgroundColorAction: (Color) -> Void
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            // MARK: - Row 1: Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "BACKGROUND COLOR")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 26) {
                        
                        // Color Picker
                        ColorPicker("Background Color Picker", selection: $selectedPickerBgColor)
                            .labelsHidden()
                        
                        // Colors
                        ForEach(backgroundColorSelection, id: \.date) { selection in
                            ColorChipButtonView(
                                isActive: selection.isSelected,
                                color: selection.color,
                                action: { selectedBackgroundColorAction(selection.date) }
                            )
                        }
                    } //: HStack
                    
                } //: ScrollView
                .frame(height: 47)
            } //: VStack
            
            // MARK: - Row 2: Item Background Color
            VStack(alignment: .leading, spacing: 15) {
                HeaderOptionsView(title: "ITEM BACKGROUND COLOR")
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 26) {
                        
                        // None
                        NoColorChipButtonView(
                            isActive: itemBackgroundColorSelection.isEmpty || selectedItemBackgroundColor == .clear
                        ) {
                            selectedItemBackgroundColor = .clear
                        }
                        
                        // Color Picker
                        ColorPicker("Item Background Color Picker", selection: $selectedPickerItemBgColor)
                            .labelsHidden()
                        
                        // Colors
                        ForEach(itemBackgroundColorSelection, id: \.date) { selection in
                            ColorChipButtonView(
                                isActive: selection.isSelected && selectedItemBackgroundColor != .clear,
                                color: selection.color,
                                action: { selectedItemBackgroundColorAction(selection.date) }
                            )
                        }
                    } //: HStack
                    
                } //: ScrollView
                .frame(height: 47)
            } //: VStack
            
        } //: VStack
        .onChange(of: selectedPickerBgColor, perform: onChangePickerBackgroundColor)
        .onChange(of: selectedPickerItemBgColor, perform: onChangePickerItemBackgroundColor)
    }
    
    // MARK: - Actions
    func onChangePickerBackgroundColor(color: Color) {
        guard let cgColor = color.cgColor, let colorComponents = cgColor.components else {
            return
        }
        pickBackgroundColorAction(.init(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2]))
    }
    
    func onChangePickerItemBackgroundColor(color: Color) {
        guard let cgColor = color.cgColor, let colorComponents = cgColor.components else {
            return
        }
        pickItemBackgroundColorAction(.init(red: colorComponents[0], green: colorComponents[1], blue: colorComponents[2]))
    }
}

// MARK: - Preview
struct SheetOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SheetOptionsView(
            /// Background
            selectedBackgroundColor: .constant(.gray),
            backgroundColorSelection: [
                .init(date: .init(), color: .gray, isSelected: true)
            ],
            selectedBackgroundColorAction: { _ in },
            pickBackgroundColorAction: { _ in },
            /// Item Background
            selectedItemBackgroundColor: .constant(.clear),
            itemBackgroundColorSelection: [],
            selectedItemBackgroundColorAction: { _ in },
            pickItemBackgroundColorAction: { _ in }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
