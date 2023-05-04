//
//  NewItemInputView.swift
//  My Expenses
//
//  Created by Wind Versi on 24/3/23.
//

import SwiftUI

typealias Action = () -> Void

struct DynamicTextField: View {
    // MARK: - Props
    var placeholder: String
    @Binding var text: String
    var commitAction: Action
    
    // MARK: - UI
    var body: some View {
        Group {
            if #available(iOS 15.0, *) {
                TextField(
                    placeholder,
                    text: $text
                )
                .onSubmit(commitAction)
                .submitLabel(.done)
            } else {
                TextField(
                    placeholder,
                    text: $text,
                    onCommit: commitAction
                )
            }
        } //: Group
    }
    
    // MARK: - Actions
}

struct NewItemInputView: View {
    // MARK: - Props
    @State private var name: String = ""
    @State private var price: String = ""
    var font: Fonts
    @Binding var isFocused: Bool
    @State private var isFocusedPrice: Bool = false

    var commitAction: (String, String) -> Void
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 18) {
            
            // MARK: Name
            CustomTextFieldView(
                text: $name,
                isFocused: $isFocused,
                font: font,
                fontSize: 15,
                keyboardType: .default,
                returnKeyType: .done,
                placeholder: "Enter Item . . .",
                onCommit: {
                    commitAction(name, price)
                }
            )
            .foregroundColor(.init(red: 242/255, green: 242/255, blue: 242/255))
            
            Spacer()
            
            // MARK: Price
            CustomTextFieldView(
                text: $price,
                isFocused: $isFocusedPrice,
                font: font,
                fontSize: 15,
                keyboardType: .decimalPad,
                returnKeyType: .done,
                placeholder: "$0",
                onCommit: {
                    commitAction(name, price)
                }
            )
            .foregroundColor(.black.opacity(0.5))
            .frame(maxWidth: 44)
            
        }
        .padding(.horizontal, 24)
        .frame(height: 63)
        .background(Color.sheetGray)
        .fillMaxWidth()
        .dynamicOverlay(alignment: .top) {
            Rectangle()
                .fill(Color.black.opacity(0.05))
                .frame(height: 1)
                .fillMaxWidth()
                .offset(y: -1)
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct NewItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemInputView(
            font: .sfProTextSemibold,
            isFocused: .constant(true),
            commitAction: { _, _ in }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
