//
//  PretendardLabel.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/27.
//

import UIKit

class PretendardLabel: UILabel {
    
    init(size: CGFloat, weight: UIFont.Weight, color: UIColor?, textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.font = .pretendard(size: size, weight: weight)
        self.textColor = color
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
