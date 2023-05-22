//
//  HeaderDateView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

final class HeaderDateView: UIView {
    
    // MARK: Properties - Data
    var previousButtonAction: (() -> Void)?
    var nextButtonAction: (() -> Void)?
    
    private var headerDate: Date = Date() {
        didSet {
            updateDateLabel()
        }
    }
    
    // MARK: Properties - View
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.addArrangedSubviews([previousButton,
                                       SeparateBarView(width: 1, height: 12),
                                       dateLabel,
                                       SeparateBarView(width: 1, height: 12),
                                       nextButton])
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.distribution = .fillProportionally
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
    init(didTapPreviousButton: @escaping (() -> Void),
         didTapNextButton: @escaping (() -> Void)
    ) {
        self.previousButtonAction = didTapPreviousButton
        self.nextButtonAction = didTapNextButton
        super.init(frame: .zero)
        
        configureHeaderDateView()
        updateDateLabel()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let headerDateViewHeight = frame.height
        layer.cornerRadius = headerDateViewHeight / 2
    }
    
    // MARK: Functions - Public
    func updateDateLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"
        
        let date = formatter.string(from: headerDate)
        dateLabel.text = date
    }
    
    func updateHeaderDate(date: Date) {
        
        self.headerDate = date
    }
    
    // MARK: Functions - Private
    private func configureHeaderDateView() {
        
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.designSystem(.mainOrange)?.cgColor
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(totalStackView)
    }
    
    private func setupShadow() {
        
        layer.applySketchShadow(color: .designSystem(.mainBlack)!, alpha: 0.1, x: 0, y: 6, blur: 24, spread: 0)
    }
    
    @objc private func didTapPreviousButton() {

        previousButtonAction?()
    }

    @objc private func didTapNextButton() {

        nextButtonAction?()
    }
}
