//
//  CalendarDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    typealias CellType = DateCell
    typealias SectionType = Section
    
    // MARK: Properties - Data
    enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, CellType.Item>?
    
    // MARK: Functions - Public
    func makeDataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, CellType.Item>? {

        let dataSource = UICollectionViewDiffableDataSource<Section, CellType.Item>(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = headerProvider
        self.dataSource = dataSource

        return dataSource
    }
    
    func update(_ items: [CellType.Item]) {

        var snapshot = NSDiffableDataSourceSnapshot<Section, CellType.Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
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
