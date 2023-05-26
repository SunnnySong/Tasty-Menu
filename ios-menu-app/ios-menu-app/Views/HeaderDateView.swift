//
//  HeaderDateView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

final class HeaderDateView: UIView {
    
    enum HeaderType {
        case calendar
        case menu
    }
    
    // MARK: Properties - Data
    var previousButtonAction: (() -> Void)?
    var nextButtonAction: (() -> Void)?
    
    private var headerDate: Date {
        didSet {
            updateDateLabel(type: headerType)
        }
    }
    
    private var headerType: HeaderType
    
    // MARK: Properties - View
    private lazy var totalStackView = totalStackView(type: headerType)
    
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
    
    private let heartButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage(systemName: "suit.heart.fill")
        button.setImage(heartImage, for: .normal)
        button.tintColor = .designSystem(.mainOrange)
        button.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()
    
    // MARK: Lifecycle
    init(didTapPreviousButton: @escaping (() -> Void),
         didTapNextButton: @escaping (() -> Void),
         headerDate: Date,
         type: HeaderType
    ) {
        self.previousButtonAction = didTapPreviousButton
        self.nextButtonAction = didTapNextButton
        self.headerDate = headerDate
        self.headerType = type
        super.init(frame: .zero)
        
        configureHeaderDateView()
        updateDateLabel(type: type)
        setupShadow()
    }
    
    init(headerDate: Date,
         type: HeaderType) {
        
        self.headerDate = headerDate
        self.headerType = type
        super.init(frame: .zero)
        
        configureHeaderDateView()
        updateDateLabel(type: type)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureHierarchy()
    }
    
    // MARK: Functions - Public
    func updateHeaderDate(_ date: Date) {
        
        self.headerDate = date
    }
    
    // MARK: Functions - Private
    private func totalStackView(type: HeaderType) -> UIStackView {
        
        let stackView = UIStackView(frame: .zero)
        
        switch type {
        case .calendar:
            stackView.addArrangedSubviews([previousButton,
                                           SeparateBarView(width: 1, height: 12),
                                           dateLabel,
                                           SeparateBarView(width: 1, height: 12),
                                           nextButton])
        case .menu:
            stackView.addArrangedSubviews([dateLabel,
                                           SeparateBarView(width: 1, height: 12),
                                           heartButton
                                          ])
        }
       
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.designSystem(.mainOrange)?.cgColor
        stackView.layer.cornerRadius = 20
        return stackView
    }
    
    private func updateDateLabel(type: HeaderType) {
        
        let formatter = DateFormatter()
        
        switch type {
        case .calendar:
            formatter.dateFormat = "YYYY년 M월"
        case .menu:
            formatter.dateFormat = "M월 d일 EEEE"
            formatter.locale = Locale(identifier: "ko_KR")
        }
        
        let date = formatter.string(from: headerDate)
        dateLabel.text = date
    }
    
    private func configureHeaderDateView() {
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
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
