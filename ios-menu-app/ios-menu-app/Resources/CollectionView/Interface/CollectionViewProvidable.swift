//
//  CollectionViewProvidable.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

typealias CollectionViewCellProvidable = UICollectionViewCell & CollectionViewProvidable

protocol CollectionViewProvidable {
    
    associatedtype Item: Hashable
    
    func configure(with item: Item)
}
