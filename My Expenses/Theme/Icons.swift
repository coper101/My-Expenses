//
//  Icons.swift
//  My Expenses
//
//  Created by Wind Versi on 1/4/23.
//

import SwiftUI

enum Icons: String {
    case delete = "delete-icon"
    case close = "close-icon"
    case noSign = "no-sign-icon"
    var image: Image {
        Image(self.rawValue)
    }
}
