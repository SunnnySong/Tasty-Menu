//
//  ListDiffableDataSourceProvider.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

final class ListDiffableDataSourceProvider: TableViewDiffableDataSourceProvidable {
    
    typealias SectionType = ListSection
    typealias ItemType = Date
    typealias DataSource = UITableViewDiffableDataSource<SectionType, ItemType>
    
    func dataSource(tableView: UITableView) -> UITableViewDiffableDataSource<SectionType, ItemType>? {
        
        let dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)

        return dataSource
    }
    
    func updateSnapshot(dates: [Date], dataSource: DataSource) {
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, ItemType>()
        snapshot.appendSections([.heartList])
        snapshot.appendItems(dates)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: Date) -> UITableViewCell? {
        
        let listCell: ListCell = tableView.dequeue(for: indexPath)
        listCell.configure(with: item)
        
        return listCell
    }
}

