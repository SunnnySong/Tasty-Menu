//
//  MenuHeaderView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/29.
//

import UIKit

final class MenuHeaderDateView: UIView {
    
    // MARK: Properties - Data
    var heartButtonAction: (() -> Void)?
    
    private var headerDate: Date {
        didSet {
            updateDateLabel()
        }
    }
    
    private var heartState: Bool = false {
        didSet {
            updateHeartButton()
        }
    }
    
    // MARK: Properties - View
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.addArrangedSubviews([dateLabel,
                                       SeparateBarView(width: 1, height: 12),
                                       heartButton
                                      ])
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.designSystem(.mainOrange)?.cgColor
        stackView.layer.cornerRadius = 20
        return stackView
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .bold)
        label.textColor = .designSystem(.mainBlack)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        button.imageView?.tintColor = .designSystem(.mainOrange)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    init(didTapHeartButton: @escaping (() -> Void),
         headerDate: Date,
         heartState: Bool) { 
        self.heartButtonAction = didTapHeartButton
        self.headerDate = headerDate
        self.heartState = heartState
        super.init(frame: .zero)
        
        configureHeaderDateView()
        updateDateLabel()
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
    
    private func updateDateLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let date = formatter.string(from: headerDate)
        dateLabel.text = date
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
    
    @objc private func didTapHeartButton() {
     
        heartButtonAction?()
    }
}
