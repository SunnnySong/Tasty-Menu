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
    
    private var date: Date = .today
    
    // MARK: Properties - View
    private lazy var menuPopupView: MenuPopupView = { [weak self] in
        MenuPopupView(
            frame: view.bounds,
            collectionView: menuCollectionView,
            headerDate: date,
            addButtonAction: {
                print("add")
            },
            closeButtonAction: {
                self?.dismiss(animated: true)
            })
    }()
    private let menuCollectionView = MenuCollectionView(frame: .zero)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 추후 clear로 변경
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
