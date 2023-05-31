//
//  MenuManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

final class MenuManager {
    
    // MARK: Properties - Data
    private let menuDiffableDataSourceProvider = MenuDiffableDataSourceProvider()
    
    private var baseDate: Date {
        didSet {
            updateMenuData()
        }
    }
    
    private var menuData: Menu? {
        didSet {
            updateSnapshot()
        }
    }
    
    // MARK: Properties - View
    private weak var collectionView: UICollectionView?
    private var dataSource: MenuDiffableDataSourceProvider.DataSource?
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView?, date: Date) {
        self.collectionView = collectionView
        self.baseDate = date
        
        updateMenuData()
    }
    
    // MARK: Functions - Public
    func getMenuHeaderComponent() -> MenuHeaderComponent {
        var isHeart: Bool = false
        
        if let menuData = menuData {
            isHeart = menuData.isHeart
        }
        
        let menuHeaderComponents = MenuHeaderComponent(date: baseDate, isHeart: isHeart)
        return menuHeaderComponents
    }
    
    func updateMenuData() {
        
        menuData = PersistenceManager.shared.fetchMenu(searchDate: baseDate)
    }
    
    func createDataSource() {
        
        guard let collectionView = collectionView,
              let dataSource = menuDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
    }
    
    func updateSnapshot() {
        
        guard let dataSource = dataSource,
                let foods = menuData?.foods?.array as? [Food] else { return }

        menuDiffableDataSourceProvider.updateSnapshot(foods: foods, dataSource: dataSource)
    }
    
    func updateHeartState(_ state: Bool) -> Bool {

        guard let menuData = menuData else {
            return false
        }
        
        PersistenceManager.shared.updateHeartState(menu: menuData, state: state)
        return true
    }
    
}
