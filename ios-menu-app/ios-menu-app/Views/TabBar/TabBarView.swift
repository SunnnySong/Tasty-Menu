//
//  TabBarView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class TabBarView: UITabBar {
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureTabBar()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = sizeThatFits.height + 5
        
        return sizeThatFits
    }
    
    // MARK: Functions - Private
    private func configureTabBar() {
        
        self.backgroundColor = .systemBackground
        self.tintColor = .designSystem(.mainOrange)
        self.unselectedItemTintColor = .designSystem(.tabBarGray)
        self.layer.borderColor = UIColor.designSystem(.tabBarSeparateGray)?.cgColor
        self.layer.borderWidth = 1
    }

}
