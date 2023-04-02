//
//  HeaderOptionsView.swift
//  My Expenses
//
//  Created by Wind Versi on 2/4/23.
//

import SwiftUI

struct HeaderOptionsView: View {
    // MARK: - Props
    var title: String
    
    // MARK: - UI
    var body: some View {
        Text(title)
            .textStyle(
                foregroundColor: .black,
                colorOpacity: 0.15,
                fontWeight: .bold,
                size: 13,
                maxWidth: .infinity,
                alignment: .leading
            )
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct HeaderOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderOptionsView(title: "COLOR")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
