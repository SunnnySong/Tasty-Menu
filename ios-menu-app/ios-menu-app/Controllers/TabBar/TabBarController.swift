//
//  TabBarController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        selectedIndex = 1
    }
    
    private func configureViewControllers() {
    
        self.viewControllers = TabBarModel.allCases.map { tabBarViewController($0) }
    }
    
    private func tabBarViewController(_ type: TabBarModel) -> UINavigationController {
        
        let viewController = UINavigationController(rootViewController: type.viewController)
        viewController.tabBarItem.title = type.title
        viewController.tabBarItem.image = type.image
        
        return viewController
    }
}

