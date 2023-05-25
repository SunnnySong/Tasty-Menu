//
//  Food+CoreDataProperties.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/25.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var categoryValue: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String?

}

extension Food : Identifiable {

}
