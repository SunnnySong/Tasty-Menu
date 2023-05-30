//
//  MenuDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

final class MenuDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    typealias SectionType = MenuSection
    typealias ItemType = MenuItem
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> DataSource?  {
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        return dataSource
    }
    
    func updateSnapshot(foods: [Food], dataSource: DataSource) {

        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.menuList])
        
        foods.forEach {
            snapshot.appendItems([.menuList($0)], toSection: .menuList)
        }
      
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Functions - Private
    private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: MenuItem) -> UICollectionViewCell? {
        
        switch item {
        case .menuList(let food):
            let menuCell: MenuCell = collectionView.dequeue(for: indexPath)
            menuCell.configure(with: food)
            return menuCell
        }
    }
}
