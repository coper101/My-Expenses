//
//  AppViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Combine
import SwiftUI

enum SheetOption {
    case background
    case sheetBackground
    case sheetItemBackground
    case textFontColor
}

enum BackgroundUsed {
    case color
    case image
}

protocol Selection {
    var date: Date { get set }
    var isSelected: Bool { get set }
}

struct ImageSelection: Selection {
    var date: Date
    var image: UIImage
    var isSelected: Bool
}

struct ColorSelection: Selection {
    var date: Date
    var color: Color
    var isSelected: Bool
}

struct FontSelection: Selection {
    var date: Date
    var font: Fonts
    var isSelected: Bool
}


final class AppViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: Data
    @Published var weekExpenses: [WeekExpense] = []
    
    // MARK: UI
    /// Tab Content
    @Published var selectedTab: TabItem = .today
    
    /// Today's Screen
    @Published var isNewItemFocused: Bool = false
    @Published var isEditing: Bool = false
    
    /// Customization
    @Published var isImagePickerShown: Bool = false
    @Published var isCustomizing: Bool = false
    
    /// [1] Background
    @Published var backgroundUsed: BackgroundUsed = .color
    
    @Published var selectedBackgroundColor: Color = .clear
    @Published var colorSelections: [ColorSelection] = []
    
    @Published var selectedBackgroundImage: UIImage?
    @Published var imageSelections: [ImageSelection] = []
    
    /// [2] Sheet
    @Published var selectedSheetBackgroundColor: Color = .sheetGray
    @Published var sheetBackgroundColorSelections: [ColorSelection] = [
        .init(date: .init(), color: .sheetGray, isSelected: true)
    ]
    
    @Published var selectedSheetItemBackgroundColor: Color = .clear
    @Published var sheetItemBackgroundColorSelections: [ColorSelection] = []
    
    /// [3] Text
    @Published var selectedFontColor: Color = .black
    @Published var fontColorSelection: [ColorSelection] = [
        .init(date: .init(), color: .black, isSelected: true)
    ]

    @Published var fontSize: Double = 18
    
    @Published var selectedFont: Fonts = .sfProTextSemibold
    @Published var fontSelections: [FontSelection] = [
        .init(date: .init(), font: .sfProTextSemibold, isSelected: true),
        .init(date: Calendar.current.date(byAdding: .day, value: -1, to: .init())!, font: .schoolbell, isSelected: false),
        .init(date: Calendar.current.date(byAdding: .day, value: -2, to: .init())!, font: .shadowsIntoLight, isSelected: false)
    ]
    
    init() {
        observe()
    }
    
    // MARK: Observers
    func observe() {
        
        /// [1A]
        $colorSelections
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                guard let selectedColor = selections.first(where: { $0.isSelected }) else {
                    return
                }
                self.selectedBackgroundColor = selectedColor.color
                self.backgroundUsed = .color
            }
            .store(in: &subscriptions)

        /// [1B]
        $imageSelections
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                let selectedImage = selections.first(where: { $0.isSelected })
                self.selectedBackgroundImage = selectedImage?.image
                self.backgroundUsed = .image
            }
            .store(in: &subscriptions)
        
        /// [2A]
        $sheetBackgroundColorSelections
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                guard let selectedColor = selections.first(where: { $0.isSelected }) else {
                    return
                }
                self.selectedSheetBackgroundColor = selectedColor.color
            }
            .store(in: &subscriptions)
        
        /// [2B]
        $sheetItemBackgroundColorSelections
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                guard let selectedColor = selections.first(where: { $0.isSelected }) else {
                    return
                }
                self.selectedSheetItemBackgroundColor = selectedColor.color
            }
            .store(in: &subscriptions)
        
        /// [3A]
        $fontColorSelection
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                guard let selection = selections.first(where: { $0.isSelected }) else {
                    return
                }
                self.selectedFontColor = selection.color
            }
            .store(in: &subscriptions)
        
        /// [3C]
        $fontSelections
            .drop(while: { $0.first(where: { $0.isSelected }) == nil })
            .sink { [weak self] selections in
                guard let self else {
                    return
                }
                guard let selection = selections.first(where: { $0.isSelected }) else {
                    return
                }
                self.selectedFont = selection.font
            }
            .store(in: &subscriptions)
    }
    
    // MARK: Events
    /// [1A] Background Image
    func addBackgroundImage(_ image: UIImage) {
        deselectSelectedBackgroundImage()
        imageSelections.insert(
            .init(date: .init(), image: image, isSelected: true),
            at: 0
        )
    }
    
    func selectBackgroundImage(with date: Date) {
        deselectSelectedBackgroundImage()
        guard let selectionIndex = imageSelections.firstIndex(where: { $0.date == date }) else {
            return
        }
        imageSelections[selectionIndex].isSelected = true
    }
    
    private func deselectSelectedBackgroundImage() {
        imageSelections.indices.forEach { imageSelections[$0].isSelected = false }
    }
        
    /// [1B, 2A, 2B]  Color
    func addColor(_ color: Color, for option: SheetOption) {
        switch option {
        case .background:
            deselectSelectedColor(for: .background)
            colorSelections.insert(
                .init(date: .init(), color: color, isSelected: true),
                at: 0
            )
        case .sheetBackground:
            deselectSelectedColor(for: .sheetBackground)
            sheetBackgroundColorSelections.insert(
                .init(date: .init(), color: color, isSelected: true),
                at: 0
            )
        case .sheetItemBackground:
            deselectSelectedColor(for: .sheetItemBackground)
            sheetItemBackgroundColorSelections.insert(
                .init(date: .init(), color: color, isSelected: true),
                at: 0
            )
        case .textFontColor:
            deselectSelectedColor(for: .textFontColor)
            fontColorSelection.insert(
                .init(date: .init(), color: color, isSelected: true),
                at: 0
            )
        }
    }
    
    func selectColor(with date: Date, for option: SheetOption) {
        switch option {
        case .background:
            deselectSelectedColor(for: .background)
            guard let selectionIndex = colorSelections.firstIndex(where: { $0.date == date }) else {
                return
            }
            colorSelections[selectionIndex].isSelected = true
        case .sheetBackground:
            deselectSelectedColor(for: .sheetBackground)
            guard let selectionIndex = sheetBackgroundColorSelections.firstIndex(where: { $0.date == date }) else {
                return
            }
            sheetBackgroundColorSelections[selectionIndex].isSelected = true
        case .sheetItemBackground:
            deselectSelectedColor(for: .sheetItemBackground)
            guard let selectionIndex = sheetItemBackgroundColorSelections.firstIndex(where: { $0.date == date }) else {
                return
            }
            sheetItemBackgroundColorSelections[selectionIndex].isSelected = true
        case .textFontColor:
            deselectSelectedColor(for: .textFontColor)
            guard let selectionIndex = fontColorSelection.firstIndex(where: { $0.date == date }) else {
                return
            }
            fontColorSelection[selectionIndex].isSelected = true
        }
    }
    
    private func deselectSelectedColor(for option: SheetOption) {
        switch option {
        case .background:
            colorSelections.indices.forEach { colorSelections[$0].isSelected = false }
        case .sheetBackground:
            sheetBackgroundColorSelections.indices.forEach { sheetBackgroundColorSelections[$0].isSelected = false }
        case .sheetItemBackground:
            sheetItemBackgroundColorSelections.indices.forEach { sheetItemBackgroundColorSelections[$0].isSelected = false }
        case .textFontColor:
            fontColorSelection.indices.forEach { fontColorSelection[$0].isSelected = false }
        }
    }
    
    /// [3]
    func selectFont(with date: Date) {
        deselectSelectedFont()
        guard let selectionIndex = fontSelections.firstIndex(where: { $0.date == date }) else {
            return
        }
        fontSelections[selectionIndex].isSelected = true
    }
    
    private func deselectSelectedFont() {
        fontSelections.indices.forEach { fontSelections[$0].isSelected = false }
    }
    
}
