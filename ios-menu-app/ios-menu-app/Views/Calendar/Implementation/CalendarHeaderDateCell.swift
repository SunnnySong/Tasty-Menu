//
//  CalendarHeaderDateView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/29.
//

import UIKit

final class CalendarHeaderDateCell: CollectionViewCellProvidable {
    
    typealias Item = Date
    
    // MARK: Properties - Data
    private let notificationCenter = NotificationCenter.default
    
    // MARK: Properties - View
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.addArrangedSubviews([previousButton,
                                       SeparateBarView(width: 1, height: 12),
                                       dateLabel,
                                       SeparateBarView(width: 1, height: 12),
                                       nextButton])
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.designSystem(.mainOrange)?.cgColor
        stackView.layer.cornerRadius = 20
        return stackView
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(imageName: .chevronLeft,
                              imageColor: .designSystem(.mainBlack),
                              insets: .init(top: 0, left: 15, bottom: 0, right: 15 / 2))
        button.addTarget(self, action: #selector(tappedPreviousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(imageName: .chevronRight,
                              imageColor: .designSystem(.mainBlack),
                              insets: .init(top: 0, left: 15 / 2, bottom: 0, right: 15))
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        return button
    }()
    
    private var dateLabel = PretendardLabel(size: 16, weight: .bold, color: .designSystem(.mainBlack), textAlignment: .center)
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureHierarchy()
        setupShadow()
    }
    
    // MARK: Functions - Public
    func configure(with item: Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"

        let date = formatter.string(from: item)
        dateLabel.text = date
    }
    
    // MARK: Functions - Private
    private func setupShadow() {
        
        totalStackView.backgroundColor = .systemBackground
        totalStackView.layer.applySketchShadow(color: .designSystem(.mainBlack)!, alpha: 0.1, x: 0, y: 6, blur: 24, spread: 0)
    }
    
    private func configureHierarchy() {
        
        addSubview(totalStackView)

        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalStackView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.59),
            totalStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func tappedPreviousButton() {

        notificationCenter.post(
            name: .tappedPreviousButton,
            object: nil)
    }

    @objc private func tappedNextButton() {

        notificationCenter.post(
            name: .tappedNextButton,
            object: nil)
    }
}
