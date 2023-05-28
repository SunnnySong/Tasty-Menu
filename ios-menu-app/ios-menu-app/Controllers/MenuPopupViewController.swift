//
//  MenuPopupViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit
import SwiftUI

final class MenuPopupViewController: UIViewController {

    // MARK: Properties - Data
    private lazy var menuManager = MenuManager(collectionView: menuCollectionView)
    
    // MARK: Properties - View
    private lazy var menuPopupView = MenuPopupView(frame: view.bounds, collectionView: menuCollectionView, headerDate: .today)
    private let menuCollectionView = MenuCollectionView(frame: .zero)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 추후 clear로 변경
//        view.backgroundColor = .clear
        view.backgroundColor = .systemBlue
        configureDataSource()
        configureHierarchy()
    }

    private func configureHierarchy() {
        
        view.addSubview(menuPopupView)
    }
    
    private func configureDataSource() {
        
        menuManager.createDataSource()
    }
}
