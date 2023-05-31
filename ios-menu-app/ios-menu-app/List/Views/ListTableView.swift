//
//  ListTableView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

final class ListTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.register(ListCell.self)
        self.separatorStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
