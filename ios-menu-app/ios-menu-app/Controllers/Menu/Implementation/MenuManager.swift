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
    
    // MARK: Properties - View
    private weak var collectionView: UICollectionView?
    private var dataSource: MenuDiffableDataSourceProvider.DataSource?
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView? = nil) {
        self.collectionView = collectionView
    }
    
    // MARK: Functions - Public
    func createDataSource() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        guard let dataSource = menuDiffableDataSourceProvider.dataSource(collectionView: collectionView) else {
            return
        }
        collectionView.dataSource = dataSource
        self.dataSource = dataSource
        update()
    }
    
    func update() {
        
        guard let dataSource = dataSource else {
            return
        }
        let image = UIImage(systemName: "suit.heart.fill")
        let mock = [
            DailyFood(name: "만두", category: .korean),
            DailyFood(image: image, name: "떡볶이", category: .chinese),
            DailyFood(image: image, name: "떡볶이", category: .chinese),
            DailyFood(image: image, name: "떡볶이", category: .chinese),
            DailyFood(image: image, name: "떡볶이", category: .chinese)
        ]
        menuDiffableDataSourceProvider.updateSnapshot(mock, to: dataSource)
    }
    
}
