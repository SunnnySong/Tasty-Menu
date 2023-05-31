//
//  AlarmSwitchView.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/31.
//

import UIKit

final class AlarmSwitchView: UIView {
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews([prepareMenuAlerm, startMenuAlerm])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 30
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var prepareMenuAlerm: UIStackView = {
        let alarmTitle: UILabel = {
            let label = PretendardLabel(size: 16,
                                        weight: .regular,
                                        color: .designSystem(.mainBlack), textAlignment: .left)
            label.text = "식사 준비"
            return label
        }()
        
        let toggleButton: UISwitch = {
            let alamSwitch = UISwitch(frame: .zero)
            alamSwitch.addTarget(self, action: #selector(didTogglePrepareMenuAlerm), for: .valueChanged)
            return alamSwitch
        }()
        
        let stackView = UIStackView()
        stackView.addArrangedSubviews([alarmTitle, toggleButton])
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var startMenuAlerm: UIStackView = {
        let alarmTitle: UILabel = {
            let label = PretendardLabel(size: 16,
                                        weight: .regular,
                                        color: .designSystem(.mainBlack), textAlignment: .left)
            label.text = "식사 시작"
            return label
        }()
        
        let toggleButton: UISwitch = {
            let alamSwitch = UISwitch(frame: .zero)
            alamSwitch.addTarget(self, action: #selector(didToggleStartMenuAlerm), for: .valueChanged)
            return alamSwitch
        }()
        
        let stackView = UIStackView()
        stackView.addArrangedSubviews([alarmTitle, toggleButton])
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        
        addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            totalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    @objc private func didTogglePrepareMenuAlerm() {
        
        print("hi hello")
    }
    
    @objc private func didToggleStartMenuAlerm() {
        
        print("hello")
    }
}
