//
//  SeparateBarView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/22.
//

import UIKit

final class SeparateBarView: UIView {
    
    // MARK: Properties - View
    private var separatorBar: UIView = {
        let view = UIView()
        view.backgroundColor = .designSystem(.separateBarGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(separatorBar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(width: CGFloat, height: CGFloat) {
        self.init(frame: .zero)
        
        configure(width: width, height: height)
    }
    
    // MARK: Functions - Private
    private func configure(width: CGFloat, height: CGFloat) {
        
        NSLayoutConstraint.activate([
            separatorBar.widthAnchor.constraint(equalToConstant: width),
            separatorBar.heightAnchor.constraint(equalToConstant: height),
            separatorBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            separatorBar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
