//
//  CalendarDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDiffableDataSourceProvider<CellType: CollectionViewCellProvidable>: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    enum Section {
        case main
    }
    
    private weak var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, CellType.Item>?
    
    // MARK: Lifecycle
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    // MARK: Functions - Public
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, CellType.Item>? {

        guard let collectionView = collectionView else { return nil }
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
