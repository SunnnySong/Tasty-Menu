//
//  MenuCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

final class MenuCell: CollectionViewCellProvidable {

    typealias Item = Food
    
    // MARK: Properties - View
    private var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.tintColor = .designSystem(.mainOrange)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var foodLabel: UILabel = {
        let label = PretendardLabel(size: 14,
                                    weight: .regular,
                                    color: .designSystem(.toolBarBlack),
                                    textAlignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = PretendardLabel(size: 12,
                                    weight: .semibold,
                                    color: .white,
                                    textAlignment: .center)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Lifecycle
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        configureHierarchy()
    }
    
    func configure(with item: Food) {
        
        if item.imageData == nil {
            foodImageView.image = ImageSystemName.photo.image
        } else {
            foodImageView.image = UIImage(data: item.imageData ?? Data())
        }
        foodLabel.text = item.name
        
        categoryLabel.text = FoodCategory(rawValue: item.categoryValue)?.title
        categoryLabel.backgroundColor = FoodCategory(rawValue: item.categoryValue)?.backgroundColor
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodLabel)
        contentView.addSubview(categoryLabel)
        
        let cellHeight = self.frame.height
        let cellWidth = self.frame.width
        let itemSpacing: CGFloat = 12
        let labelVerticalSapcing: CGFloat = 4
        let labelWidth = cellWidth * 0.173
        
        categoryLabel.layer.cornerRadius = (cellHeight - labelVerticalSapcing * 2) / 2
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foodImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height),
            
            foodLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: itemSpacing),
            foodLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: labelVerticalSapcing),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelVerticalSapcing),
            categoryLabel.leadingAnchor.constraint(equalTo: foodLabel.trailingAnchor, constant: itemSpacing),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.widthAnchor.constraint(equalToConstant: labelWidth)
        ])
    }
}
