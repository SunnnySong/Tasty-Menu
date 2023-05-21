//
//  WeakView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

final class WeakView: UICollectionReusableView {
    
    private let weakTitle = ["일", "월", "화", "수", "목", "금", "토"]
    
    private lazy var weakStackView: UIStackView = {
        let stackView = UIStackView()
        let weakLabels = weakTitle.map { makeWeakLabel(title: $0) }
        stackView.addArrangedSubviews(weakLabels)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeWeakLabel(title: String) -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.pretendard(size: 14, weight: .semibold)
        label.textAlignment = .center
        label.text = title
        
        if label.text == weakTitle[0] {
            label.textColor = .systemRed
        }
        return label
    }
    
    private func configureHierarchy() {
        
        self.addSubview(weakStackView)
        
        NSLayoutConstraint.activate([
            weakStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weakStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weakStackView.topAnchor.constraint(equalTo: self.topAnchor),
            weakStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


