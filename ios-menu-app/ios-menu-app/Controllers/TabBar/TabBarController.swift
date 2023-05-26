//
//  TabBarController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(TabBarView(frame: tabBar.frame), forKey: "tabBar")
        configureViewControllers()
    }
    
    // MARK: Functions - Private
    private func configureViewControllers() {
    
        self.viewControllers = TabBarModel.allCases.map { tabBarViewController($0) }
        selectedIndex = 1
    }
    
    private func tabBarViewController(_ type: TabBarModel) -> UINavigationController {
        
        let viewController = UINavigationController(rootViewController: type.viewController)
        viewController.tabBarItem.title = type.title
        viewController.tabBarItem.image = type.image
        
        return viewController
    }
}

