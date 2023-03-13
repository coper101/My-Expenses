//
//  Todays.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct TodaysView: View {
    // MARK: - Props
    @EnvironmentObject var appViewModel: AppViewModel

    // MARK: - UI
    var body: some View {
        VStack(spacing: 40) {
            
            // Row 1: CONTENT
            VStack(alignment: .leading, spacing: 11) {
                
                // TITLE
                Text("Today's Expenses")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.2,
                        fontWeight: .semibold,
                        size: 24
                    )
                
                // EXPENSES
                ForEach(1...6, id: \.self) { _ in
                    
                    HStack(alignment: .bottom, spacing: 14) {
                        
                        // TIME
                        Text("9:00")
                            .textStyle(
                                foregroundColor: .black,
                                colorOpacity: 0.2,
                                fontWeight: .semibold,
                                size: 12
                            )
                            .padding(.bottom, 2)
                            .frame(width: 38, alignment: .trailing)
                        
                        // NAME
                        Text("Train")
                            .textStyle(
                                foregroundColor: .black,
                                fontWeight: .semibold,
                                size: 18
                            )
                        
                        // GUIDE LINE
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
                        .frame(height: 2)
                        .padding(.bottom, 4)
                        
                                                    
                        // PRICE
                        Text("1.97")
                            .textStyle(
                                foregroundColor: .black,
                                fontWeight: .semibold,
                                size: 14
                            )
                        
                    } //: HStack
                    .padding(.vertical, 22)
                    .padding(.leading, 4)
                    .padding(.trailing, 15)
                    
                } //: ForEach
                
                // TOTAL PRICE
                HStack(alignment: .bottom, spacing: 12) {
                    
                    // TITLE
                    Text("Total")
                        .textStyle(
                            foregroundColor: .black,
                            fontWeight: .semibold,
                            size: 18
                        )
                    
                    // GUIDE LINE
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
                    .frame(height: 2)
                    .padding(.bottom, 4)
                    
                    // PRICE
                    Text("8.14")
                        .textStyle(
                            foregroundColor: .black,
                            fontWeight: .semibold,
                            size: 14
                        )
                    
                } //: HStack
                .padding(.trailing, 14)
                .padding(.leading, 38 + 14)
                .padding(.top, 40 - 12)
                
            } //: VStack
            
            // Row 2: INPUT
            HStack(spacing: 0) {
                TextField("Enter Item . . .", text: .constant(""))
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.2,
                        fontWeight: .semibold,
                        size: 15
                    )
                Spacer()
                Text("Scribble")
                    .textStyle(
                        foregroundColor: .black,
                        colorOpacity: 0.1,
                        fontWeight: .semibold,
                        size: 15
                    )
            } //: HStack

        } //: VStack
        .padding(.top, 32)
        .padding(.bottom, 18)
        .padding(.horizontal, 24)
        .background(Color.gray.opacity(0.2))
        .padding(.horizontal, 21)
        .padding(.top, 8)
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct TodaysExpenses_Previews: PreviewProvider {
    static var previews: some View {
        TodaysView()
            .previewLayout(.sizeThatFits)
            .background(Color.white)
            .padding()
            .background(Color.green)
            .environmentObject(AppViewModel())
    }
}
