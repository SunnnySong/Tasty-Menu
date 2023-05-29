//
//  MenuDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

struct MenuDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    typealias CellType = MenuCell
    typealias SectionType = Section
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MenuCell.Item>
    
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, MenuCell.Item>? {
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)

        return dataSource
    }
    
    func updateSnapshot(_ items: [Food], to dataSource: UICollectionViewDiffableDataSource<Section, MenuCell.Item>) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellType.Item>()
        snapshot.appendSections([.calendar])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: Functions - Private
    private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: CellType.Item) -> UICollectionViewCell? {
        
        collectionView.register(CellType.self)
        
        let cell: CellType = collectionView.dequeue(for: indexPath)
        cell.configure(with: item)
        
        return cell
    }
}
