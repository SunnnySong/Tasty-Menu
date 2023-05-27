//
//  MenuPopupView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/26.
//

import UIKit

final class MenuPopupView: UIView {
    
    // MARK: Properties - View
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerDateView = HeaderDateView(headerDate: .today, type: .menu)
    
    private let menuCollectionView = MenuCollectionView(frame: .zero)
    
    private lazy var toolBarAddButton: ToolBarButton = {
        let button = ToolBarButton(type: .add)
        button.addTarget(self, action: #selector(didTaptoolBarAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolBarCloseButton: ToolBarButton = {
        let button = ToolBarButton(type: ._close)
        button.addTarget(self, action: #selector(didTaptoolBarCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolBarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubviews([toolBarAddButton, toolBarCloseButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureMenuPopupView()
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configurePopupViewHierarchy()
    }
    
    // MARK: Functions - Private
    private func configureMenuPopupView() {
        
        backgroundColor = .designSystem(.mainBlack)?.withAlphaComponent(0.6)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func configureHierarchy() {
        
        addSubview(popupView)
        
        let popupStackViewWidth = frame.width * 0.87
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupView.heightAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configurePopupViewHierarchy() {
        
        popupView.addSubview(headerDateView)
        popupView.addSubview(toolBarStackView)
        
        let popupViewHeight = popupView.frame.height
        let headerDateViewHeight = popupViewHeight * 0.275
        let toolBarStackViewHeight = popupViewHeight * 0.15
        NSLayoutConstraint.activate([
            headerDateView.topAnchor.constraint(equalTo: popupView.topAnchor),
            headerDateView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            headerDateView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            headerDateView.heightAnchor.constraint(equalToConstant: headerDateViewHeight),
            
            toolBarStackView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor),
            toolBarStackView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            toolBarStackView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            toolBarStackView.heightAnchor.constraint(equalToConstant: toolBarStackViewHeight)
        ])
    }
    
    @objc private func didTaptoolBarAddButton() {
        print("didTaptoolBarAddButton")
    }
    
    @objc private func didTaptoolBarCloseButton() {
        print("didTaptoolBarCloseButton")
    }
}
