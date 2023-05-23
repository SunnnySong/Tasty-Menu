//
//  CalendarDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    typealias CellType = DateCell
    typealias SectionType = Section
    typealias DataSource = UICollectionViewDiffableDataSource<Section, DateCell.Item>
        
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> DataSource? {

        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = headerProvider

        return dataSource
    }
    
    func updateSnapshot(_ items: [CellType.Item], to dataSource: DataSource) {

        var snapshot = NSDiffableDataSourceSnapshot<Section, CellType.Item>()
        snapshot.appendSections([.main])
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
    
    private func headerProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        collectionView.headerRegister(WeakView.self)
        let header: WeakView = collectionView.headerDequeue(for: indexPath)
        
        return header
    }
}
