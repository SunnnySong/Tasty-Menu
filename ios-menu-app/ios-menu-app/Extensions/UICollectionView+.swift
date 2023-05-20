//
//  UICollectionView+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func headerRegister<T: UICollectionReusableView>(_ cellType: T.Type) {
        register(cellType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
        
        return cell
    }
    
    func headerDequeue<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                      withReuseIdentifier: T.reuseIdentifier,
                                                      for: indexPath) as! T
        return header
    }
}
