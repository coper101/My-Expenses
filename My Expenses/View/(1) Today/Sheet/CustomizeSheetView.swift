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
                        SheetOptionsView(
                            /// Background
                            selectedBackgroundColor: $appViewModel.selectedSheetBackgroundColor,
                            backgroundColorSelection: appViewModel.sheetBackgroundColorSelections,
                            selectedBackgroundColorAction: selectedBackgroundColorAction,
                            pickBackgroundColorAction: pickBackgroundColorAction,
                            /// Item Background
                            selectedItemBackgroundColor: $appViewModel.selectedSheetItemBackgroundColor,
                            itemBackgroundColorSelection: appViewModel.sheetItemBackgroundColorSelections,
                            selectedItemBackgroundColorAction: selectedItemBackgroundColorAction,
                            pickItemBackgroundColorAction: pickItemBackgroundColorAction
                        )
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
    /// [1] Background Option
    func pickImageAction() {
        appViewModel.isImagePickerShown = true
    }
    
    func selectImageAction(date: Date) {
        appViewModel.selectBackgroundImage(with: date)
    }
    
    func pickColorAction(color: Color) {
        appViewModel.addColor(color, for: .background)
    }
    
    func selectColorAction(date: Date) {
        appViewModel.selectColor(with: date, for: .background)
    }
    
    /// [2] Sheet Option
    func pickBackgroundColorAction(color: Color) {
        appViewModel.addColor(color, for: .sheetBackground)
    }
    
    func selectedBackgroundColorAction(date: Date) {
        appViewModel.selectColor(with: date, for: .sheetBackground)
    }
    
    func pickItemBackgroundColorAction(color: Color) {
        appViewModel.addColor(color, for: .sheetItemBackground)
    }
    
    func selectedItemBackgroundColorAction(date: Date) {
        appViewModel.selectColor(with: date, for: .sheetItemBackground)
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
