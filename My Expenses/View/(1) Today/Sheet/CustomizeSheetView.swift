//
//  CustomizeSheetView.swift
//  My Expenses
//
//  Created by Wind Versi on 1/4/23.
//

import SwiftUI

enum SheetContent: String, Identifiable, CaseIterable {
    case background = "Background"
    case sheet = "Sheet"
    case text = "Text"
    case appIcon = "App Icon"
    
    var id: String {
        self.rawValue
    }
}

struct CustomizeSheetView: View {
    // MARK: - Props
    @State var selectedSheetContent: SheetContent = .background
    var closeAction: Action
    
    // MARK: - UI
    var body: some View {
        ZStack(alignment: .top) {
            
            // MARK: Top Bar
            SheetTopBarView(
                selectedSheetContent: $selectedSheetContent,
                closeAction: closeAction
            )
            .padding(.horizontal, 21)
            .padding(.vertical, 24)
            
            // MARK: Content
            VStack(spacing: 0) {
                Spacer()
            }
            
        } //: ZStack
        .frame(height: 366, alignment: .top)
        .background(Color.white)
        .cornerRadius(radius: 25, corners: [.topLeft, .topRight])
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct CustomizeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeSheetView(closeAction: {})
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
    }
}
