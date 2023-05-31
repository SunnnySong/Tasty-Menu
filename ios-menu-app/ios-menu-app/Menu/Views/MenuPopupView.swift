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
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let headerView = MenuHeaderDateView()
    private let footerView = MenuFooterView()
    private var menuCollectionView: UICollectionView?
    
    // MARK: Lifecycle
    init(frame: CGRect,
         collectionView: UICollectionView,
         menuHeaderComponent: MenuHeaderComponent
    ) {
        super.init(frame: frame)
        self.menuCollectionView = collectionView
        
        headerView.configure(with: menuHeaderComponent)
        configureHierarchy()
        configureMenuPopupView()
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
        
        let popupStackViewWidth = frame.width * 0.89
        NSLayoutConstraint.activate([
            popupView.widthAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupView.heightAnchor.constraint(equalToConstant: popupStackViewWidth),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configurePopupViewHierarchy() {
        
        guard let menuCollectionView = menuCollectionView else { return }
        popupView.addSubview(menuCollectionView)
        popupView.addSubview(headerView)
        popupView.addSubview(footerView)
        
        let popupViewHeight = popupView.frame.height
        let headerDateViewHeight = popupViewHeight * 0.275
        let toolBarStackViewHeight = popupViewHeight * 0.15
        let menuCollectionViewHorizontal: CGFloat = 16
        let menuCollectionViewBottom: CGFloat = -24
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: popupView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerDateViewHeight),
            
            menuCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuCollectionView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: menuCollectionViewHorizontal),
            menuCollectionView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -menuCollectionViewHorizontal),
            menuCollectionView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: menuCollectionViewBottom),
            
            footerView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: toolBarStackViewHeight)
        ])
    }
}
