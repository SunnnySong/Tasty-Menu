//
//  ListCell.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

final class ListCell: TableViewCellProvidable {
  
    typealias Item = Date
    
    private lazy var listStackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.addArrangedSubviews([dateLabel, heartButton])
        stackView.alignment = .center
        return stackView
    }()
    
    private var dateLabel: UILabel = {
        let label = PretendardLabel(size: 16,
                                    weight: .regular,
                                    color: .designSystem(.mainBlack), textAlignment: .left)
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(imageName: .heartFill,
                              imageColor: .designSystem(.mainOrange),
                              insets: .init(top: 10, left: 10, bottom: 10, right: 10))
        button.layer.borderColor = UIColor.designSystem(.separateBarGray)?.cgColor
        button.layer.borderWidth = 1
//        button.clipsToBounds = true
//        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        addSubview(listStackView)
    }
    
    func configure(with item: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let date = formatter.string(from: item)
        dateLabel.text = date
    }
    
    @objc private func didTapHeartButton() {
        
    }
}
