//
//  UIButton+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/27.
//

import UIKit

extension UIButton {
    
    convenience init(imageName: ImageSystemName,
                     imageColor: UIColor?,
                     insets: UIEdgeInsets
    ) {
        self.init()
        
        let image = UIImage(systemName: imageName.rawValue)
        setImage(image, for: .normal)
        imageView?.tintColor = imageColor
        contentEdgeInsets = insets
    }
}

