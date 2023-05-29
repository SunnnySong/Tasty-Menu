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
    var previousButtonAction: (() -> Void)?
    var nextButtonAction: (() -> Void)?
    
//    private var headerDate: Date {
//        didSet {
//            updateDateLabel()
//        }
//    }
    
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
        let button = UIButton()
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .designSystem(.mainBlack)
        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        button.contentEdgeInsets = .init(top: 0, left: 15, bottom: 0, right: 15 / 2)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.right")
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .designSystem(.mainBlack)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.contentEdgeInsets = .init(top: 0, left: 15 / 2, bottom: 0, right: 15)
        return button
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .bold)
        label.textColor = .designSystem(.mainBlack)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Lifecycle
//    init(didTapPreviousButton: @escaping (() -> Void),
//         didTapNextButton: @escaping (() -> Void),
//         headerDate: Date
//    ) {
//        self.previousButtonAction = didTapPreviousButton
//        self.nextButtonAction = didTapNextButton
////        self.headerDate = headerDate
//        super.init(frame: .zero)
//
//        configureHeaderDateView()
////        updateDateLabel()
//        setupShadow()
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureHierarchy()
    }
    
    // MARK: Functions - Public
    func configure(with item: Date) {

        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"

        let date = formatter.string(from: item)
        dateLabel.text = date
    }
    
//    func updateHeaderDate(_ date: Date) {
//
//        self.headerDate = date
//    }
    
    // MARK: Functions - Private
//    private func updateDateLabel() {
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY년 M월"
//
//        let date = formatter.string(from: headerDate)
//        dateLabel.text = date
//    }
    
    private func configureHeaderDateView() {
        
        backgroundColor = .systemBackground
//        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupShadow() {
        
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
    
    @objc private func didTapPreviousButton() {

        previousButtonAction?()
    }

    @objc private func didTapNextButton() {

        nextButtonAction?()
    }
}
