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
        imageView.setContentHuggingPriority(.dragThatCannotResizeScene, for: .horizontal)
        return imageView
    }()
    
    private var foodLabel: UILabel = {
        let label = PretendardLabel(size: 14,
                                    weight: .regular,
                                    color: .designSystem(.toolBarBlack),
                                    textAlignment: .left)
        label.backgroundColor = .green
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .pretendard(size: 12, weight: .regular)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [foodImageView, foodLabel])
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
    }
    
    func configure(with item: DailyFood) {
        
        foodImageView.image = item.image
        foodLabel.text = item.name
        
        categoryLabel.text = item.category.title
        categoryLabel.backgroundColor = item.category.backgroundColor
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(totalStackView)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: totalStackView.trailingAnchor, constant: 12),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryLabel.widthAnchor.constraint(equalToConstant: 53),
            categoryLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
