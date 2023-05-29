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
    typealias ItemType = Day
    
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, ItemType>?
    private let calendar = Calendar(identifier: .gregorian)
    
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<SectionType, ItemType>? {

        collectionView.register(CalendarHeaderDateCell.self)
        collectionView.register(DateCell.self)
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell in
            
            print("\(indexPath), \(item)")
            switch Section.allCases[indexPath.section] {
            case .headerDate:
                let headerCell: CalendarHeaderDateCell = collectionView.dequeue(for: indexPath)
                headerCell.configure(with: item.date)
                return headerCell
            case .main:
                let dateCell: DateCell = collectionView.dequeue(for: indexPath)
                dateCell.configure(with: item)
                return dateCell
            }
        }
        dataSource?.supplementaryViewProvider = headerProvider
        
        return dataSource
    }
    
    func updateSnapshot(with items: [Day]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.headerDate, .main])
        
        snapshot.appendItems(items, toSection: .main)
        snapshot.appendItems([items[0].reversed()], toSection: .headerDate)
        
        dataSource?.apply(snapshot)
    }
    
    private func headerProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        collectionView.headerRegister(WeakView.self)
        let header: WeakView = collectionView.headerDequeue(for: indexPath)
        
        return header
    }
}
