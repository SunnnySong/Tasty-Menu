//
//  MenuPopupViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuPopupViewController: UIViewController {
    
    // MARK: Properties - Data
    private var selectedDate: Date = .today
    var heartStateCallback: (() -> Void)?
    
    private lazy var menuManager = MenuManager(collectionView: menuCollectionView, date: selectedDate)
    private let notificationCenter = NotificationCenter.default
    
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
        
        tappedFooterCloseButton()
        tappedFooterAddButton()
        
        menuHeaderHeartToggle()
    }
    
    // MARK: Functions - Public
    func updateDay(_ date: Date) {
        
        self.selectedDate = date
    }
    
    // MARK: Functions - Private
    private func configureHierarchy() {
        
        view.addSubview(menuPopupView)
    }
    
    private func configureDataSource() {
        
        menuManager.createDataSource()
    }
    
    private func tappedFooterCloseButton() {
        
        notificationCenter.addObserver(
            forName: .tappedCloseButton,
            object: nil,
            queue: nil) { [weak self] _ in
                self?.dismiss(animated: true)
            }
    }
    
    private func tappedFooterAddButton() {
        
        notificationCenter.addObserver(
            self,
            selector: #selector(presentFoodViewController),
            name: .tappedAddButton,
            object: nil)
    }
    
    private func menuHeaderHeartToggle() {
        
        notificationCenter.addObserver(
            self,
            selector: #selector(changeHeartState(_:)),
            name: .menuHeaderHeartToggle,
            object: nil)
    }
    
    @objc private func changeHeartState(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let heartState = userInfo[NotificationKeys.menuHeartState] as? Bool
        else { return }
        
        if menuManager.updateHeartState(heartState) {
            heartStateCallback?()
        }
    }
    
    @objc private func presentFoodViewController() {
        
        let foodViewController = FoodViewController()
        foodViewController.modalPresentationStyle = .pageSheet
        foodViewController.menuPopupViewDelegate = self
        foodViewController.configureSelectedDate(selectedDate)
        
        let navigationFoodViewController = UINavigationController(rootViewController: foodViewController)
        present(navigationFoodViewController, animated: true)
    }
}

extension MenuPopupViewController: MenuPopupViewDelegate {
    
    func didDismissFoodViewController() {
        
        menuManager.updateMenuData()
    }
}
