//
//  SystemName.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/27.
//

import UIKit

enum ImageSystemName: String {
    
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case heartFill = "suit.heart.fill"
    case heart = "heart"
    case photo = "photo"
    case multiPhoto = "photo.on.rectangle"
    case check = "checkmark"
    case trash = "trash"
    
    var image: UIImage? {
        UIImage(systemName: self.rawValue)
    }
}
