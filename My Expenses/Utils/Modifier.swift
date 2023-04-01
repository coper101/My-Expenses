//
//  Modifier.swift
//  My Expenses
//
//  Created by Wind Versi on 1/4/23.
//

import SwiftUI

extension View {
    
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        _ transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(
            content: self,
            modifier: CornerRadiusStyle(radius: radius, corners: corners)
        )
    }
    
    func dynamicOverlay(
        alignment: Alignment,
        _ theContent: @escaping () -> some View
    ) -> some View {
        modifier(
            DynamicOverlayModifier(
                alignment: alignment,
                theContent: theContent
            )
        )
    }
}



struct DynamicOverlayModifier<TheContent>: ViewModifier where TheContent: View {
    // MARK: Props
    var alignment: Alignment
    var theContent: () -> TheContent
    
    // MARK: UI
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 15.0, *) {
                content.overlay(alignment: alignment, content: theContent)
            } else {
                content.overlay(theContent(), alignment: alignment)
            }
        }
    }
}



struct CornerRadiusStyle: ViewModifier {
    // MARK: Props
    var radius: CGFloat
    var corners: UIRectCorner

    // MARK: UI
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

