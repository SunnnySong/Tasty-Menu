//
//  UITableViewCell+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
