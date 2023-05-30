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
    private lazy var menuManager = MenuManager(collectionView: menuCollectionView, date: date)
    private var date: Date = .today
    
    // MARK: Properties - View
    private lazy var menuPopupView: MenuPopupView = {
        MenuPopupView(
            frame: view.bounds,
            collectionView: menuCollectionView,
            menuHeaderComponent: menuManager.getMenuHeaderComponent())
    }()
    private let menuCollectionView = MenuCollectionView(frame: .zero)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        configureDataSource()
        configureHierarchy()
    }

    // MARK: Functions - Public
    func updateDay(_ date: Date) {
        
        self.date = date
    }
    
    // MARK: Functions - Private
    private func configureHierarchy() {
        
        view.addSubview(menuPopupView)
    }
    
    private func configureDataSource() {
        
        menuManager.createDataSource()
    }
}
