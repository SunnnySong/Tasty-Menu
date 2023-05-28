//
//  MenuCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

final class MenuCell: CollectionViewCellProvidable {

    typealias Item = DailyFood
    
    // MARK: Properties - View
    private var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var foodLabel: UILabel = {
        let label = PretendardLabel(size: 14,
                                    weight: .regular,
                                    color: .designSystem(.toolBarBlack),
                                    textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .pretendard(size: 12, weight: .regular)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 32 / 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        configureHierarchy()
    }
    
    func configure(with item: DailyFood) {
        
        foodImageView.image = item.image
        foodLabel.text = item.name
        
        categoryLabel.text = item.category.title
        categoryLabel.backgroundColor = item.category.backgroundColor
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodLabel)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: 40),
            
            foodLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 12),
            foodLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            categoryLabel.leadingAnchor.constraint(equalTo: foodLabel.trailingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.widthAnchor.constraint(equalToConstant: 53),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
