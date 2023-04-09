//
//  ColorPickerDemo.swift
//  My Expenses
//
//  Created by Wind Versi on 9/4/23.
//

import SwiftUI

struct ColorPickerDemo: View {
    // MARK: - Props
    @State var bgColor: Color = .red
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 0) {
            ColorPicker("", selection: $bgColor)
                .labelsHidden()
            .background(Color.blue)
            
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct ColorPickerDemo_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerDemo()
            .previewLayout(.sizeThatFits)
            // .background(Colors.Background)
    }
}
