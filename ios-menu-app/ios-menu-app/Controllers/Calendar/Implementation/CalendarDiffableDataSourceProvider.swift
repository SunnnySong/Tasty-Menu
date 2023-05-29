//
//  CalendarDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    typealias SectionType = Section
    typealias ItemType = Item
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>?
    private let calendar = Calendar(identifier: .gregorian)
    
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<SectionType, ItemType>? {
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell in
            
            switch SectionType(rawValue: indexPath.section) {
            case .headerDate:
                collectionView.register(CalendarHeaderDateCell.self)
                let headerCell: CalendarHeaderDateCell = collectionView.dequeue(for: indexPath)
                headerCell.configure(with: item.headerDate)
                return headerCell
            case .main:
                collectionView.register(DateCell.self)
                let dateCell: DateCell = collectionView.dequeue(for: indexPath)
                dateCell.configure(with: item.calendarDay)
                return dateCell
            case .none:
                return UICollectionViewCell()
            }
        }
        dataSource?.supplementaryViewProvider = headerProvider
        
        return dataSource
    }
    
    func updateSnapshot(with items: [Item]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.headerDate, .main])
        snapshot.appendItems(items)
        
        dataSource?.apply(snapshot)
    }
    
    private func headerProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        collectionView.headerRegister(WeakView.self)
        let header: WeakView = collectionView.headerDequeue(for: indexPath)
        
        return header
    }
}
