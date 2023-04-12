//
//  ImageChipButtonView.swift
//  My Expenses
//
//  Created by Wind Versi on 9/4/23.
//

import SwiftUI

struct ImageChipButtonView: View {
    // MARK: - Props
    var isActive: Bool
    var action: Action
    var image: UIImage
    
    // MARK: - UI
    var body: some View {
        RectangularChipButtonView(
            isActive: isActive,
            action: action
        ) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 118 - 15, height: 82 - 15)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct ImageChipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ImageChipButtonView(
            isActive: true,
            action: {},
            image: UIImage(named: Icons.backgroundImage1.rawValue)!
        )
        .previewLayout(.sizeThatFits)
    }
}
