//
//  HeaderDateView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

final class HeaderDateView: UIView {
    
    var previousButtonAction: (() -> Void)?
    var nextButtonAction: (() -> Void)?
    
    private var headerDate: Date = Date() {
        didSet {
            updateDateLabel()
        }
    }
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView(frame: self.bounds)
        stackView.addArrangedSubviews([previousButton,
                                       SeparateBarView(width: 1, height: 12),
                                       dateLabel,
                                       SeparateBarView(width: 1, height: 12),
                                       nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .designSystem(.mainBlack)
        button.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "chevron.right")
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .designSystem(.mainBlack)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(size: 16, weight: .bold)
        label.textColor = .designSystem(.mainBlack)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHeaderDateView()
        updateDateLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let headerDateViewWidth = frame.width
        let headerDateViewHeight = frame.height
        
        layer.cornerRadius = headerDateViewHeight / 2
        
        addSubview(totalStackView)

        let totalStackViewConstant = headerDateViewWidth * 0.18 / 2
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: totalStackViewConstant),
            totalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -totalStackViewConstant),
            totalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeaderDateView() {
        
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.designSystem(.mainOrange)?.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func didTapPreviousButton() {
        
        previousButtonAction?()
        print(" 전달로 이동 ")
    }
    
    @objc private func didTapNextButton() {
        
        nextButtonAction?()
        print(" 다음 달로 이동 ")
    }
    
    private func updateDateLabel() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"
        
        let headerDate = formatter.string(from: headerDate)
        dateLabel.text = headerDate
    }
    
    func updateHeaderDate(date: Date) {
        
        self.headerDate = date
    }
}
