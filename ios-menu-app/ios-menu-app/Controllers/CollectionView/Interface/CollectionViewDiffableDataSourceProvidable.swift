//
//  CollectionViewDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/20.
//

import UIKit

protocol CollectionViewDiffableDataSourceProvidable {
    
    associatedtype SectionType: Hashable
    associatedtype ItemType: Hashable
    associatedtype DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    
    func dataSource(collectionView: UICollectionView) -> DataSource?
}
