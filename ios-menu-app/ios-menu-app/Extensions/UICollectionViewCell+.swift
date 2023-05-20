//
//  UICollectionViewCell+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
