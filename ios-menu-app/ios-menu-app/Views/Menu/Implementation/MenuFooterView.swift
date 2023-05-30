//
//  MenuFooterView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit

final class MenuFooterView: UIView {
    
    // MARK: Properties - Data
    private let notificationCenter = NotificationCenter.default
    
    // MARK: Properties - View
    private lazy var toolBarAddButton: ToolBarButton = {
        let button = ToolBarButton(type: .add)
        button.addTarget(self, action: #selector(tappedAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolBarCloseButton: ToolBarButton = {
        let button = ToolBarButton(type: ._close)
        button.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        
        addSubview(toolBarStackView)
        
        NSLayoutConstraint.activate([
            toolBarStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            toolBarStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            toolBarStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            toolBarStackView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    @objc private func tappedAddButton() {
        
        print("add 버튼 눌림")
    }
    
    @objc private func tappedCloseButton() {
        
        notificationCenter.post(
            name: .tappedCloseButton,
            object: nil)
    }
}
