//
//  Menu+CoreDataProperties.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/25.
//
//

import Foundation
import CoreData


extension Menu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest<Menu>(entityName: "Menu")
    }

    @NSManaged public var date: Date
    @NSManaged public var isHeart: Bool
    @NSManaged public var foods: NSOrderedSet?

}

// MARK: Generated accessors for foods
extension Menu {

    @objc(insertObject:inFoodsAtIndex:)
    @NSManaged public func insertIntoFoods(_ value: Food, at idx: Int)

    @objc(removeObjectFromFoodsAtIndex:)
    @NSManaged public func removeFromFoods(at idx: Int)

    @objc(insertFoods:atIndexes:)
    @NSManaged public func insertIntoFoods(_ values: [Food], at indexes: NSIndexSet)

    @objc(removeFoodsAtIndexes:)
    @NSManaged public func removeFromFoods(at indexes: NSIndexSet)

    @objc(replaceObjectInFoodsAtIndex:withObject:)
    @NSManaged public func replaceFoods(at idx: Int, with value: Food)

    @objc(replaceFoodsAtIndexes:withFoods:)
    @NSManaged public func replaceFoods(at indexes: NSIndexSet, with values: [Food])

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: Food)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: Food)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSOrderedSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSOrderedSet)

}

extension Menu : Identifiable {
    
}
