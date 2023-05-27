//
//  ToolBarButton.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

class ToolBarButton: UIButton {

    enum ToolBarButtonType: String {
        case add = "추가"
        case _close = "닫기"
        
        var backgroundColor: UIColor? {
            switch self {
            case .add:
                return .designSystem(.toolBarGray)
            case ._close:
                return .designSystem(.mainOrange)
            }
        }
        
        var font: UIFont! {
            .pretendard(size: 14, weight: .regular)
        }
        
        var textColor: UIColor? {
            switch self {
            case .add:
                return .designSystem(.toolBarBlack)
            case ._close:
                return .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: ToolBarButtonType) {
        self.init(frame: .zero)
        
        backgroundColor = type.backgroundColor
        setTitle(type.rawValue, for: .normal)
        titleLabel?.font = type.font
        setTitleColor(type.textColor, for: .normal)
    }
}
