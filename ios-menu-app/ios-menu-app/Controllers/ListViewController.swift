//
//  ListViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class ListViewController: UIViewController {
    
    private lazy var listManager = ListManager(tableView: listTableView)
    private lazy var listTableView = ListTableView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        listTableView.delegate = self
        
        configureHierarchy()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listManager.updateHeartMenusData()
    }
    
    private func configureDataSource() {
        
        listManager.createDataSource()
    }
    
    private func configureHierarchy() {
        
        view.addSubview(listTableView)
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}
