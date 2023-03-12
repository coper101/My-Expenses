//
//  Todays.swift
//  My Expenses
//
//  Created by Wind Versi on 12/3/23.
//

import SwiftUI

struct TodaysView: View {
    // MARK: - Props
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Top Bar
            HStack(spacing: 10) {
                Button(action: {}) {
                    Text("Edit")
                        .textStyle(
                            foregroundColor: .black,
                            colorOpacity: 0.2,
                            fontWeight: .semibold,
                            size: 18
                        )
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Customize")
                        .textStyle(
                            foregroundColor: .black,
                            colorOpacity: 0.2,
                            fontWeight: .semibold,
                            size: 18
                        )
                }
            }
            .padding(.horizontal, 21)
            
            // MARK: Sheet
            VStack(spacing: 40) {
                
                // Sheet
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
                            
                            // NAME
                            Text("Train")
                                .textStyle(
                                    foregroundColor: .black,
                                    fontWeight: .semibold,
                                    size: 18
                                )
                            
                            // GUIDE LINE
                            GeometryReader { geometry in
                                HStack(spacing: 5) {
                                    ForEach(1...12, id: \.self) { _ in
                                        Circle()
                                            .fill(Color.black.opacity(0.2))
                                            .frame(width: 2, height: 2)
                                    }
                                }
                            }
                            .frame(height: 2)
                            .padding(.bottom, 4)
                            
                            
                            Spacer()
                            
                            // TIME
                            Text("1.97")
                                .textStyle(
                                    foregroundColor: .black,
                                    fontWeight: .semibold,
                                    size: 14
                                )
                            
                        } //: HStack
                        .padding(.vertical, 22)
                        
                    } //: ForEach
                    
                } //: VStack
                .padding(.horizontal, 21)
                
                // Input
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
                            colorOpacity: 0.2,
                            fontWeight: .semibold,
                            size: 15
                        )
                }
                .padding(.horizontal, 21)

            }
            .padding(.top, 32)
            .padding(.bottom, 18)
            .padding(.horizontal, 22)
            .background(Color.gray.opacity(0.2))
            .padding(.horizontal, 21)

            
            // MARK: Bottom Bar
        }
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct TodaysExpenses_Previews: PreviewProvider {
    static var previews: some View {
        TodaysView()
            .previewLayout(.sizeThatFits)
            // .background(Colors.Background)
    }
}
