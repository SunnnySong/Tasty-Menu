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
}
