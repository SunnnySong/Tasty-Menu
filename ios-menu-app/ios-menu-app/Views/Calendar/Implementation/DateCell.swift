//
//  DateCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class DateCell: CollectionViewCellProvidable {
    
    typealias Item = Int
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureCell()
        configureDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    func configure(with item: Int) {
        
        label.text = item.description
    }
    
    private func configureHierarchy() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        contentView.addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(10)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    private func configureCell() {
        
        contentView.backgroundColor = .systemBlue
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    private func configureDateLabel() {
        
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
}
