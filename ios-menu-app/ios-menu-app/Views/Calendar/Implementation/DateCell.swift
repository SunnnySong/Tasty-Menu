//
//  DateCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/19.
//

import UIKit

final class DateCell: CollectionViewCellProvidable {

    typealias Item = Day
    
    // MARK: Properties - View
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .pretendard(size: 12, weight: .bold)
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
        
        layer.addBorder([.top], color: .designSystem(.separateBarGray), width: 1)
    }
    
    // MARK: 그럼 updateConstraints 는 언제 호출되는거지?
    // 내가 configure 만든 것과 다르게 호출되나?
    // 둘 중 어떤 방법을 사용하는 것이 좋은 거지?

//    private var items: Item?
    
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        super.updateConfiguration(using: state)
//
//        print("updateConfiguration 호출")
//
//        guard let items = items else { return }
//
//        numberLabel.text = items.number
//
//        if items.isIncludeInMonth {
//            numberLabel.textColor = items.isSelected ? .white : .designSystem(.mainBlack)
//        } else {
//            numberLabel.textColor = .designSystem(.calendarDayGray)
//        }
//
//        print(items.isSelected)
//        selectionView.isHidden = !items.isSelected
//        heartImageView.isHidden = !items.hasHeart
//    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        print("prepareForReuse 실행")
//    }
    
    // MARK: Functions - Public
    func configure(with dayData: Day) {
        
        numberLabel.text = dayData.number
        
        if dayData.isIncludeInMonth {
            numberLabel.textColor = dayData.isSelected ? .white : .designSystem(.mainBlack)
        } else {
            numberLabel.textColor = .designSystem(.calendarDayGray)
        }
        
        selectionView.isHidden = !dayData.isSelected
        heartImageView.isHidden = !dayData.hasHeart
    }
    
    // MARK: Functions - Private
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
