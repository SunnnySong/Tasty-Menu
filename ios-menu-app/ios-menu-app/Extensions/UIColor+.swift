//
//  UIColor+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

extension UIColor {
    class func designSystem(_ color: Palette) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
