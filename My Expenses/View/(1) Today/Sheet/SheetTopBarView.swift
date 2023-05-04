//
//  SheetTopBarView.swift
//  My Expenses
//
//  Created by Wind Versi on 1/4/23.
//

import SwiftUI

struct SheetTopBarView: View {
    // MARK: - Props
    @Binding var selectedSheetContent: SheetContent
    var closeAction: Action
    
    // MARK: - UI
    var body: some View {
        HStack(spacing: 18) {
            
            // MARK: Selections
            ZStack(alignment: .trailing) {
                
                // MARK: Content
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(SheetContent.allCases) { content in
                            SheetTabItemView(
                                title: content.id,
                                isActive: selectedSheetContent == content,
                                action: {
                                    selectedSheetContent = content
                                }
                            )
                        } //: ForEach
                    } //: HStack
                }
                
                // MARK: Visual Gradient
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 44)
                    .allowsHitTesting(false)
                
            } //: ZStack
            .frame(height: 29)
            
            // MARK: Close
            Button(action: closeAction) {
                Icons.close.image
                    .resizable()
                    .frame(width: 27, height: 27)
                    .scaledToFit()
                    .foregroundColor(.primaryLight)
            }
            
        } //: ScrollView
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct SheetTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        SheetTopBarView(
            selectedSheetContent: .constant(.background),
            closeAction: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
