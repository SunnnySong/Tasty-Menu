//
//  MenuPopupViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuPopupViewController: UIViewController {

    // MARK: Properties - View
    private lazy var menuPopupView = MenuPopupView(frame: view.bounds)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 추후 clear로 변경
//        view.backgroundColor = .clear
        view.backgroundColor = .systemBackground
        configureHierarchy()
    }

    private func configureHierarchy() {
        
        view.addSubview(menuPopupView)
    }
}
