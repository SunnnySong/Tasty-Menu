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
            menuData = PersistenceManager.shared.fetchMenu(searchDate: baseDate)
        }
    }
    
    private lazy var menuData: Menu? = PersistenceManager.shared.fetchMenu(searchDate: baseDate) {
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
    
    func createDataSource() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        guard let dataSource = menuDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
        
        updateSnapshot()
    }
    
    func updateSnapshot() {
        
        guard let dataSource = dataSource else { return }
        guard let foods = menuData?.foods?.array as? [Food] else { return }

        menuDiffableDataSourceProvider.updateSnapshot(foods: foods, dataSource: dataSource)
    }
    
    func updateHeartState(_ state: Bool) {

        guard let menuData = menuData else {
            return
        }
        
        PersistenceManager.shared.updateHeartState(menu: menuData, state: state)
    }
    
}
