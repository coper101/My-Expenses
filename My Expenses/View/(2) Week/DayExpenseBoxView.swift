//
//  DayExpenseBoxView.swift
//  My Expenses
//
//  Created by Wind Versi on 13/3/23.
//

import SwiftUI

enum Day: Int {
    case sun, mon, tue, wed, thu, fri, sat
    
    var abbr: String {
        switch self {
        case .sun:
            return "Sun"
        case .mon:
            return "Mon"
        case .tue:
            return "Tue"
        case .wed:
            return "Wed"
        case .thu:
            return "Thu"
        case .fri:
            return "Fri"
        case .sat:
            return "Sat"
        }
    }
}

struct DayExpenseBoxView: View {
    // MARK: - Props
    var width: CGFloat
    var day: Day
    var price: Double
    var itemsCount: Int
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            Text(day.abbr)
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    fontWeight: .semibold,
                    size: 18
                )
            
            Text(String(format: "%.2f", price))
                .textStyle(
                    foregroundColor: .black,
                    fontWeight: .semibold,
                    size: 18
                )
            
            Text("\(itemsCount) Items")
                .textStyle(
                    foregroundColor: .black,
                    colorOpacity: 0.2,
                    fontWeight: .semibold,
                    size: 12
                )
            
        } //: VStack
        .padding(.leading, 18)
        .fillMaxWidth(alignment: .leading)
        .frame(height: width)
        .background(Color.black.opacity(0.05))
    }
    
    // MARK: - Actions
}

// MARK: - Preview
struct DayExpenseBoxView_Previews: PreviewProvider {
    static var previews: some View {
        DayExpenseBoxView(
            width: 102,
            day: .sun,
            price: 11.30,
            itemsCount: 4
        )
            .previewLayout(.sizeThatFits)
            .frame(width: 102)
            .background(Color.white)
            .padding()
            .background(Color.green)
    }
}
