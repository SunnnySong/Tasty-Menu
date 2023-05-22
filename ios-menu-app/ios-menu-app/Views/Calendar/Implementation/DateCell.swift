//
//  DateCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class DateCell: CollectionViewCellProvidable {

    typealias Item = Day
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .pretendard(size: 12, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.mainBlack)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "suit.heart.fill")
        imageView.tintColor = .designSystem(.mainOrange)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.addBorder([.top], color: .designSystem(.separateBarGray), width: 1)
    }
    
    func configure(with day: Day) {
        
        numberLabel.text = day.number
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(selectionView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(heartImageView)
        
        let topinset: CGFloat = 15
        
        let contentHeight = contentView.frame.height
        
        let selectionDateSize = contentHeight / 3.5
        let heartImageSize = contentHeight / 6
        
        NSLayoutConstraint.activate([
                numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topinset),
                numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                selectionView.centerYAnchor
                    .constraint(equalTo: numberLabel.centerYAnchor),
                selectionView.centerXAnchor
                    .constraint(equalTo: numberLabel.centerXAnchor),
                selectionView.widthAnchor.constraint(equalToConstant: selectionDateSize),
                selectionView.heightAnchor
                    .constraint(equalTo: selectionView.widthAnchor),
                
                heartImageView.centerXAnchor.constraint(equalTo: numberLabel.centerXAnchor),
                heartImageView.topAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: 8),
                heartImageView.widthAnchor.constraint(equalToConstant: heartImageSize),
                heartImageView.heightAnchor.constraint(equalTo: heartImageView.widthAnchor)
        ])
        
        selectionView.layer.cornerRadius = selectionDateSize / 2
    }
}
