//
//  CalendarDataSource.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDataSource: DiffableDataSourceProvider<DateCell> {
    
    override init(collectionView: UICollectionView, items: [Int]) {
        super.init(collectionView: collectionView, items: items)
    }
}
