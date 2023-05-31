//
//  UITableView+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        
        register(cellType, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        
        return cell
    }
}
