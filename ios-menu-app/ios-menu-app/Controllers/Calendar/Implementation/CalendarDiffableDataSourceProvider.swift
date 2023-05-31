//
//  CalendarDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class CalendarDiffableDataSourceProvider: CollectionViewDiffableDataSourceProvidable {
    
    // MARK: Properties - Data
    typealias SectionType = CalendarSection
    typealias ItemType = CalendarItem
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ItemType>
    
    private let calendar = Calendar(identifier: .gregorian)
    
    // MARK: Functions - Public
    func dataSource(collectionView: UICollectionView) -> DataSource? {
        
        let dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource.supplementaryViewProvider = headerProvider

        return dataSource
    }
    
    func updateSnapshot(header baseDate: Date, calendar calendarDay: [DayComponent], dataSource: DataSource) {

        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.headerDate, .calendar])

        snapshot.appendItems([.header(baseDate)], toSection: .headerDate)
        calendarDay.forEach { snapshot.appendItems([.calendar($0)], toSection: .calendar)}

        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: CalendarItem) -> UICollectionViewCell? {
        
        switch item {
        case .header(let date):
            let headerCell: CalendarHeaderDateCell = collectionView.dequeue(for: indexPath)
            headerCell.configure(with: date)
            return headerCell
        case .calendar(let day):
            let dateCell: DateCell = collectionView.dequeue(for: indexPath)
            if calendar.isDateInToday(day.date) {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
            }
            dateCell.configure(with: day)
            return dateCell
        }
    }
    
    private func headerProvider(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        
        collectionView.headerRegister(WeakView.self)
        let header: WeakView = collectionView.headerDequeue(for: indexPath)
        
        return header
    }
}
