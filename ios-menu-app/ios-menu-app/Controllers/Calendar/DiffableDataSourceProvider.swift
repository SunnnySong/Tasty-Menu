//
//  DiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

class DiffableDataSourceProvider<CellType: CollectionViewCellProvidable> {
    
    enum Section {
        case main
    }
    
    private weak var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, CellType.Item>?
    
    private var items: [CellType.Item] = []
    
    init(collectionView: UICollectionView, items: [CellType.Item]) {
        self.collectionView = collectionView
        self.items = items
    }
    
    private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: CellType.Item) -> UICollectionViewCell? {
        
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseIdentifier)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseIdentifier, for: indexPath) as? CellType else {
            return UICollectionViewCell()
        }
        
        cell.configure(item: item)
        
        return cell
    }
    
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, CellType.Item>? {
        
        guard let collectionView = collectionView else { return nil }
        let dataSource = UICollectionViewDiffableDataSource<Section, CellType.Item>(collectionView: collectionView, cellProvider: cellProvider)
        self.dataSource = dataSource
        return dataSource
    }
    
    func update() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellType.Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
}
