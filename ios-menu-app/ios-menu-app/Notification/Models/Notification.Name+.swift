//
//  Notification.Name +.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import Foundation

extension NSNotification.Name {
    
    // Calendar의 <> 버튼 눌렀을 때
    static let tappedPreviousButton = Notification.Name("tappedPreviousButton")
    static let tappedNextButton = Notification.Name("tappedNextButton")
    
    // MenuPopupView의 footer 버튼
    static let tappedAddButton = Notification.Name("tappedAddButton")
    static let tappedCloseButton = Notification.Name("tappedCloseButton")
    
    // MenuHeaderDateView에서 heart 버튼 눌렀을 시 수행
    static let menuHeaderHeartToggle = Notification.Name("menuHeaderHeartToggle")
    
    // FoodModalView에서 image 클릭되었을 때, image view present 하는 코드
}
