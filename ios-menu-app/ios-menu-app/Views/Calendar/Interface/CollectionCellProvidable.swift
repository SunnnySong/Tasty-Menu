//
//  CollectionCellProvidable.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

typealias CollectionViewCellProvidable = UICollectionViewCell & CollectionCellProvidable

protocol CollectionCellProvidable {
    
    associatedtype Item: Hashable
    
    func configure(item: Item)
}

extension CollectionCellProvidable {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
