//
//  MenuHeaderDateView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuHeaderDateView: UIView {
    
    // MARK: Properties - Data
    private var headerDate: Date {
        didSet {
            updateDateLabel()
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
    
    private let heartButton: UIButton = {
        let button = UIButton()
        let heartImage = UIImage(systemName: "suit.heart.fill")
        button.setImage(heartImage, for: .normal)
        button.tintColor = .designSystem(.mainOrange)
        button.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 10)
        return button
    }()
    
    // MARK: Lifecycle
    init(headerDate: Date) {
        self.headerDate = headerDate
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

        configureHierarchy()
    }
    
    // MARK: Functions - Public
    func updateHeaderDate(_ date: Date) {
        
        self.headerDate = date
    }
    
    // MARK: Functions - Private
    private func configureHeaderDateView() {
        
        backgroundColor = .systemBackground
//        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateDateLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let date = formatter.string(from: headerDate)
        dateLabel.text = date
    }
    
    private func setupShadow() {
        
        layer.applySketchShadow(color: .designSystem(.mainBlack)!, alpha: 0.1, x: 0, y: 6, blur: 24, spread: 0)
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
}
