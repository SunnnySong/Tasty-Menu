//
//  DailyFood.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/28.
//

import UIKit

struct DailyFood: Hashable {
    
    let id = UUID()
    var image: UIImage?
    var name: String
    var category: FoodCategory
}
