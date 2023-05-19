//
//  CollectionViewCellProvidable.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

typealias CollectionViewCellProvidable = UICollectionViewCell & CellProvidable

protocol CellProvidable {
    
    associatedtype Item: Hashable
    
    func configure(item: Item)
}

extension CellProvidable {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
