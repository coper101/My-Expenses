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
                placeholder: "Enter Item . . .",
                onCommit: {
                    print("name: \(name) price \(price)")
                    commitAction(name, price)
                    
                }
            )
            .textStyle(
                foregroundColor: .init(red: 242/255, green: 242/255, blue: 242/255),
                fontWeight: .semibold,
                size: 15
            )
            
            Spacer()
            
            // MARK: Price
            CustomTextFieldView(
                text: $price,
                isFocused: $isFocusedPrice,
                placeholder: "$0",
                onCommit: {
                    commitAction(name, price)
                }
            )
            .textStyle(
                foregroundColor: .black,
                colorOpacity: 0.5,
                fontWeight: .semibold,
                size: 15,
                textAlignment: .trailing
            )
            .frame(maxWidth: 44)
            
        }
        .padding(.horizontal, 24)
        .frame(height: 63)
        .background(Color.gray.opacity(0.2))
        .fillMaxWidth()
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct NewItemInputView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemInputView(
            isFocused: .constant(true),
            commitAction: { _, _ in }
        )
        .previewLayout(.sizeThatFits)
    }
}
