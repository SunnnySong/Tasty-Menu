//
//  PersistenceManager.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/25.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    // MARK: Properties - Data
    static let shared: PersistenceManager = PersistenceManager()
    
    private init() {}
    
    private let persistentContainerName = "Menu"
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // context 저장
    func save() {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // Read
    func fetch<T: NSManagedObject>() -> [T] {
        
        do {
            let request: NSFetchRequest = T.fetchRequest()
            guard let result = try context.fetch(request) as? [T] else {
                return []
            }
            return result
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // Create - Menu & Food
    
    // Update - add Food
    
    // Delete - Food
    
    
}

