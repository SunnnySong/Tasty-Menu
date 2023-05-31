//
//  UICollectionReusableView+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

extension UICollectionReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
