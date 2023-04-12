//
//  AppViewModel.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import Combine
import SwiftUI

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
    
    
    init() {
        observe()
    }
    
    // MARK: Observers
    func observe() {
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
    }
    
    // MARK: Events
    /// Background Image
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
    
    /// Background Color
    func addBackgroundColor(_ color: Color) {
        deselectSelectedColor()
        colorSelections.insert(
            .init(date: .init(), color: color, isSelected: true),
            at: 0
        )
    }
    
    func selectBackgroundColor(with date: Date) {
        deselectSelectedColor()
        guard let selectionIndex = colorSelections.firstIndex(where: { $0.date == date }) else {
            return
        }
        colorSelections[selectionIndex].isSelected = true
    }
    
    private func deselectSelectedColor() {
        colorSelections.indices.forEach { colorSelections[$0].isSelected = false }
    }
    
}
