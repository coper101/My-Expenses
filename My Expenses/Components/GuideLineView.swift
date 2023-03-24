//
//  GuideLineView.swift
//  My Expenses
//
//  Created by Wind Versi on 24/3/23.
//

import SwiftUI

struct GuideLineView: View {
    // MARK: - Props
    
    // MARK: - UI
    var body: some View {
        GeometryReader { geometry in

            let width = geometry.size.width

            HStack(spacing: 5) {

                ForEach(1..<Int(width / 6.5), id: \.self) { _ in

                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 2, height: 2)

                } //: ForEach

            } //: HStack

        } //: GeometryReader
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct GuideLineView_Previews: PreviewProvider {
    static var previews: some View {
        GuideLineView()
            .padding(.top, 10)
            .padding(.horizontal, 12)
            .frame(width: 130, height: 20, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
}
