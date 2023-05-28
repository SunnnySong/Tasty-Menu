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
    var heartButtonAction: (() -> Void)?
    
    private var headerDate: Date {
        didSet {
            updateDateLabel(type: headerType)
        }
    }
    
    private var headerType: HeaderType
    
    private var heartState: Bool = false {
        didSet {
            updateHeartButton()
        }
    }
    
    // MARK: Properties - View
    private lazy var totalStackView = totalStackView(type: headerType)
    
    private lazy var previousButton: UIButton = {
        let button = UIButton(imageName: .chevronLeft,
                              imageColor: .designSystem(.mainBlack),
                              insets: .init(top: 0, left: 15, bottom: 0, right: 15 / 2))
        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(imageName: .chevronRight,
                              imageColor: .designSystem(.mainBlack),
                              insets: .init(top: 0, left: 15 / 2, bottom: 0, right: 15))
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private var dateLabel: UILabel = PretendardLabel(size: 16,
                                                     weight: .bold,
                                                     color: .designSystem(.mainBlack),
                                                     textAlignment: .center)
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        button.imageView?.tintColor = .designSystem(.mainOrange)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
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
    
    init(didTapHeartButton: @escaping (() -> Void),
         headerDate: Date,
         heartState: Bool,
         type: HeaderType) {
        
        self.heartButtonAction = didTapHeartButton
        self.headerDate = headerDate
        self.heartState = heartState
        self.headerType = type
        super.init(frame: .zero)
        
        configureHeaderDateView()
        updateDateLabel(type: type)
        updateHeartButton()
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
    
    func updateHeartButtonToggle() {
        
        self.heartState.toggle()
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
    
    private func updateHeartButton() {
        
        if heartState {
            let image = UIImage(systemName: ImageSystemName.heartFill.rawValue)
            heartButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: ImageSystemName.heart.rawValue)
            heartButton.setImage(image, for: .normal)
        }
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
    
    @objc private func didTapHeartButton() {
     
        heartButtonAction?()
    }
}
