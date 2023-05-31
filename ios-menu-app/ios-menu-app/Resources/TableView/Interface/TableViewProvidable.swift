//
//  TableViewProvidable.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

typealias TableViewCellProvidable = UITableViewCell & TableViewProvidable

protocol TableViewProvidable {
    
    associatedtype Item: Hashable
    
    func configure(with item: Item)
}
