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
        
        configureTabBar()
        configureViewControllers()
    }
    
    private func configureTabBar() {
        
        let tabBar = TabBarView(frame: tabBar.frame)
        setValue(tabBar, forKey: "tabBar")
    }
    
    // MARK: Functions - Private
    private func configureViewControllers() {
    
        self.viewControllers = TabBarModel.allCases.map { tabBarViewController($0) }
        selectedIndex = 1
    }
    
    private func tabBarViewController(_ type: TabBarModel) -> UINavigationController {
        
        let viewController = UINavigationController(rootViewController: type.viewController)
        configureNavigationTitle(navigationController: viewController)
        configureNavigationBarAppearance(navigationBar: viewController.navigationBar)
        viewController.tabBarItem.title = type.title
        viewController.tabBarItem.image = type.image
        
        return viewController
    }
    
    private func configureNavigationTitle(navigationController: UINavigationController) {
        
        let titleLabel = PretendardLabel(size: 21, weight: .bold, color: UIColor.white, textAlignment: .left)
        titleLabel.text = "야곰 아카데미 식단표"

        let rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController.topViewController?.navigationItem.leftBarButtonItem = rightBarButtonItem
        
        navigationController.navigationBar.topItem?.prompt = ""
    }
    
    private func configureNavigationBarAppearance(navigationBar: UINavigationBar) {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .designSystem(.mainOrange)

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}

