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
    case plus = "plus-icon"
    
    case backgroundImage1 = "bg-image-1"
    case backgroundImage2 = "bg-image-2"
    
    var image: Image {
        Image(self.rawValue)
    }
}

