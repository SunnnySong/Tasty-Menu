//
//  FoodManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/30.
//

import UIKit

final class FoodManager {
    
    func addFood(_ foodList: FoodList, to date: Date) {
        
        if let menu = PersistenceManager.shared.fetchMenu(searchDate: date) {
            PersistenceManager.shared.add(
                image: foodList.image,
                name: foodList.name,
                category: foodList.categroy,
                to: menu)
        } else {
            let newMenu = PersistenceManager.shared.createMenu(date: date)
            PersistenceManager.shared.add(
                image: foodList.image,
                name: foodList.name,
                category: foodList.categroy,
                to: newMenu)
        }
    }
    
}
