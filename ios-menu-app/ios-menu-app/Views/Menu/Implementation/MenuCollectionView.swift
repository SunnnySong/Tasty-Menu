//
//  MenuCollectionView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuCollectionView: UICollectionView {

    // MARK: Properties - Data
    private var layout: UICollectionViewLayout {
        
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .yellow
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    // MARK: Lifecycle
    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = layout
        
        self.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
