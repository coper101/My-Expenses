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
    @EnvironmentObject var appViewModel: AppViewModel
    
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
            .padding(.top, 24)
            .padding(.bottom, 18)
            .background(Color.white)
            .zIndex(1)
            
            // MARK: Content
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 15) {

                    switch selectedSheetContent {
                    case .background:
                        BackgroundOptionsView(
                            backgroundUsed: $appViewModel.backgroundUsed,
                            /// Color
                            selectedColor: $appViewModel.selectedBackgroundColor,
                            colorSelection: appViewModel.colorSelections,
                            selectedColorAction: selectColorAction,
                            pickColorAction: pickColorAction,
                            /// Image
                            selectedImage: $appViewModel.selectedBackgroundImage,
                            imagesSelection: appViewModel.imageSelections,
                            pickImageAction: pickImageAction,
                            selectedImageAction: selectImageAction
                        )
                    case .sheet:
                        Text("TODO")
                    case .text:
                        Text("TODO")
                    case .appIcon:
                        Text("TODO")
                    }
                }
                .padding(.top, 74)
                .padding(.horizontal, 21)
                
            } //: ScrollView
            .zIndex(0)
            
        } //: ZStack
        .frame(height: 366, alignment: .top)
        .background(Color.white)
        .cornerRadius(radius: 25, corners: [.topLeft, .topRight])
    }
    
    // MARK: - Actions
    func pickImageAction() {
        appViewModel.isImagePickerShown = true
    }
    
    func selectImageAction(date: Date) {
        appViewModel.selectBackgroundImage(with: date)
    }
    
    func pickColorAction(color: Color) {
        appViewModel.addBackgroundColor(color)
    }
    
    func selectColorAction(date: Date) {
        appViewModel.selectBackgroundColor(with: date)
    }
}

// MARK: - Preview
struct CustomizeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeSheetView(closeAction: {})
            .environmentObject(AppViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.green)
    }
}
