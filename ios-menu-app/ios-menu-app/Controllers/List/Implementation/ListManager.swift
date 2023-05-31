//
//  ListManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

final class ListManager {
    
    private let listDiffableDataSourceProvider = ListDiffableDataSourceProvider()
    
    private var heartMenus: [Menu]? {
        didSet {
            updateSnapshot()
        }
    }
    
    private weak var tableView: UITableView?
    private var dataSource: ListDiffableDataSourceProvider.DataSource?
    
    init(tableView: UITableView?) {
        self.tableView = tableView
        
        updateHeartMenusData()
    }
    
    func createDataSource() {
        
        guard let tableView = tableView else {
            return
        }
        
        guard let dataSource = listDiffableDataSourceProvider.dataSource(tableView: tableView) else {
            return
        }
        tableView.dataSource = dataSource
        self.dataSource = dataSource
        
        updateSnapshot()
    }
    
    func updateHeartMenusData() {
        
        heartMenus = PersistenceManager.shared.fetchHeartMenu()
    }
    
    func updateSnapshot() {
        
        guard let dataSource = dataSource, let heartMenus = heartMenus else { return }
        
        let dates = heartMenus.map { menu in
            menu.date
        }.sorted { $0 > $1 }
        
        listDiffableDataSourceProvider.updateSnapshot(dates: dates, dataSource: dataSource)
    }
    
    func updateHeartState(state: Bool, indexPath: IndexPath) -> Bool {

        guard let heartMenus = heartMenus else {
            return false
        }
        
        let menu = heartMenus[indexPath.item]
        PersistenceManager.shared.updateHeartState(menu: menu, state: state)
        return true
    }
    
}
