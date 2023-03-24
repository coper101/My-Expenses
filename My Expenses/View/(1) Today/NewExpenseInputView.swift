//
//  NewExpenseInputView.swift
//  My Expenses
//
//  Created by Wind Versi on 19/3/23.
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

struct NewExpenseInputView: View {
    // MARK: - Props
    @State private var text: String = ""
    var commitAction: (String) -> Void
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 0) {
            
            // MARK: Text Field
            DynamicTextField(
                placeholder: "Enter Item . . .",
                text: $text,
                commitAction: { commitAction(text) }
            )
            .textStyle(
                foregroundColor: .black,
                colorOpacity: 0.2,
                fontWeight: .semibold,
                size: 15
            )
            
            Spacer()
            
            // MARK: Open Scribble
            Text("Scribble")
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.1,
                    fontWeight: .semibold,
                    size: 15
                )
            
        } //: HStack
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct NewExpenseInputView_Previews: PreviewProvider {
    static var previews: some View {
        NewExpenseInputView(commitAction: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
