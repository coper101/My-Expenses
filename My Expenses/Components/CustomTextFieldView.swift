//
//  CustomTextFieldView.swift
//  My Expenses
//
//  Created by Wind Versi on 24/3/23.
//

import SwiftUI
 
struct CustomTextFieldView: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
    @State private var focusCount = 0
    let keyboardType: UIKeyboardType
    let returnKeyType: UIReturnKeyType
    var placeholder: String
    var onCommit: () -> Void
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.returnKeyType = returnKeyType
        textField.keyboardType = keyboardType
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        DispatchQueue.main.async {
            if isFocused, !textField.isFirstResponder, focusCount == 0 {
                textField.becomeFirstResponder()
                focusCount += 1
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        .init(text: $text, isFocused: $isFocused, onCommit: onCommit)
    }
}

extension CustomTextFieldView {
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        @Binding var isFocused: Bool
        var onCommit: () -> Void
        
        init(
            text: Binding<String>,
            isFocused: Binding<Bool>,
            onCommit: @escaping () -> Void
        ) {
            self._text = text
            self._isFocused = isFocused
            self.onCommit = onCommit
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("end")
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("begin")
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            print(textField.text ?? "")
            text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            isFocused = false
            onCommit()
            return true
        }
                        
    }
}
