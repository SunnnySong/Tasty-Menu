//
//  MenuPopupView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuPopupView: UIView {
    
    // MARK: Properties - View
    private let popupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground
        return stackView
    }()
    
    private let headerDateView = MenuHeaderDateView(headerDate: .today)
    
    private let menuCollectionView = MenuCollectionView(frame: .zero)

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureMenuPopupView()
        configureHierarchy()
        configurePopupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions - Private
    private func configureMenuPopupView() {
        
        backgroundColor = .designSystem(.mainBlack)?.withAlphaComponent(0.6)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(popupStackView)
    }
    
    private func configureHierarchy() {
        
        let popupStackViewWidth = frame.width * 0.87
        
        NSLayoutConstraint.activate([
            popupStackView.widthAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupStackView.heightAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configurePopupStackView() {
        
        popupStackView.addArrangedSubviews([headerDateView, menuCollectionView])
    }
}
