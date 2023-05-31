//
//  TableViewDiffableDataSourceProvidable.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

protocol TableViewDiffableDataSourceProvidable {
    
    associatedtype SectionType: Hashable
    associatedtype ItemType: Hashable
    associatedtype DataSource = UITableViewDiffableDataSource<SectionType, ItemType>
    
    func dataSource(tableView: UITableView) -> DataSource?
}
