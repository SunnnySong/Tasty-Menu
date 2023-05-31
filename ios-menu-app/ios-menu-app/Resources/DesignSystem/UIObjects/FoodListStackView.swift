//
//  FoodListTextField.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit

final class FoodListTextField: UIStackView {
    
    enum FoodListType: String {
        case menu = "메뉴"
    }

    private var titleLabel: UILabel = {
        let label = PretendardLabel(size: 17,
                                    weight: .semibold,
                                    color: .designSystem(.mainBlack),
                                    textAlignment: .left)
        return label
    }()
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.font = .pretendard(size: 15, weight: .regular)
        textField.placeholder = "메뉴 이름을 입력해주세요"
        textField.becomeFirstResponder()
        return textField
    }()
    
    init(type: FoodListType) {
        super.init(frame: .zero)
        
        spacing = 15
        titleLabel.text = type.rawValue
        configureHierarchy()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getFoodTitle() -> String {
        
        textField.text ?? ""
    }
    
    private func configureHierarchy() {
        
        addArrangedSubviews([titleLabel, textField])

        let titleLabelWidth: CGFloat = 60
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: titleLabelWidth).isActive = true
    }
}
