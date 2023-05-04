//
//  Text.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct CustomText: ViewModifier {
    // MARK: - Props
    var foregroundColor: Color
    var font: Fonts
    var size: CGFloat
    var maxWidth: CGFloat?
    var alignment: Alignment
    var lineLimit: Int?
    var lineSpacing: CGFloat
    var textAlignment: TextAlignment
    
    // MARK: - UI
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .font(Font.custom(font.value, size: size))
            .frame(
                maxWidth: maxWidth,
                alignment: alignment
            )
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing)
            .multilineTextAlignment(textAlignment)
    }
}

extension View {
    
    /// Sets the style of the Text
    ///
    /// - Parameters:
    ///   - foregroundColor: The color of the text
    ///   - colorOpacity: The opacity of the text color
    ///   - font: The font of text
    ///   - size: The font size
    ///   - maxWidth: The text will fill all the available width of its parent
    ///   - alignment: The alignment of the text relative to its width
    ///   - linelimit: Limit the text per line. Overflowing text in single line will be truncated with ...
    ///   - lineSpacing: The space between lines of text
    ///   - textAlignment: The alignment of multiline text
    ///
    /// - Returns: A Text View with new Style
    func textStyle(
        foregroundColor: Color = .gray,
        colorOpacity: Double = 1,
        font: Fonts = .sfProTextRegular,
        size: CGFloat = 12,
        maxWidth: CGFloat? = nil,
        alignment: Alignment = .leading,
        lineLimit: Int? = 1,
        lineSpacing: CGFloat = 0,
        textAlignment: TextAlignment = .leading
    ) -> some View {
        self.modifier(
            CustomText(
                foregroundColor: foregroundColor.opacity(colorOpacity),
                font: font,
                size: size,
                maxWidth: maxWidth,
                alignment: alignment,
                lineLimit: lineLimit,
                lineSpacing: lineSpacing,
                textAlignment: textAlignment
            )
        )
    }
    
}
