//
//  HeaderView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/21.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    private let weakTitle = ["일", "월", "화", "수", "목", "금", "토",]
    
    private var weakStackView: UIStackView {
        let stackView = UIStackView(frame: self.bounds)
        let weakLabels = weakTitle.map { makeWeakLabel(title: $0) }
        stackView.addArrangedSubviews(weakLabels)
        
        return stackView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
//        configureCell()
//        configureDateLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeWeakLabel(title: String) -> UILabel {
        
        let label = UILabel()
        label.font = UIFont.pretendard(size: ._13, weight: .black)
        label.text = title
        
        if label.text == weakTitle[0] {
            label.textColor = .systemRed
        }
        return label
    }
    
    private func configureHierarchy() {
        
        self.addSubview(weakStackView)
    }
}


extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        
        views.map { self.addArrangedSubview($0) }
    }
}
