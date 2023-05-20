//
//  UIStackView+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        
        views.forEach { self.addArrangedSubview($0) }
    }
}
