//
//  PushAlarmViewController.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

final class PushAlarmViewController: UIViewController {

    private lazy var alarmSwitchView = AlarmSwitchView(frame: view.bounds)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        
        view.addSubview(alarmSwitchView)
    }
    
}
