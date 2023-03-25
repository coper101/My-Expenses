//
//  InputNavigatorView.swift
//  My Expenses
//
//  Created by Wind Versi on 19/3/23.
//

import SwiftUI

struct InputNavigatorView: View {
    // MARK: - Props
    @State private var text: String = ""
    var enterItemAction: Action
    var scribbleAction: Action
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 0) {
            
            // MARK: Open Text Field
            Button(action: enterItemAction) {
                Text("Enter Item . . .")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.2,
                        fontWeight: .semibold,
                        size: 15
                    )
            }
            
            Spacer()
            
            // MARK: Open Scribble
            Button(action: scribbleAction) {
                Text("Scribble")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.1,
                        fontWeight: .semibold,
                        size: 15
                    )
            }
            
        } //: HStack
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct NewExpenseInputView_Previews: PreviewProvider {
    static var previews: some View {
        InputNavigatorView(
            enterItemAction: {},
            scribbleAction: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
