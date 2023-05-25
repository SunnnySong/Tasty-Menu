//
//  Food+CoreDataClass.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/25.
//
//

import Foundation
import CoreData

@objc(Food)
public class Food: NSManagedObject {
    
    var category: FoodCategory {
        get {
            return FoodCategory(rawValue: self.categoryValue) ?? .etc
        }
        set {
            self.categoryValue = newValue.rawValue
        }
    }
}
