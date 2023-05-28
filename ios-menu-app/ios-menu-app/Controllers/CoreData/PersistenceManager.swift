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
    
    private var context: NSManagedObjectContext {
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
    //    func fetch<T: NSManagedObject>() -> [T] {
    //
    //        do {
    //            let request: NSFetchRequest = T.fetchRequest()
    //            guard let result = try context.fetch(request) as? [T] else {
    //                return []
    //            }
    //            return result
    //        } catch {
    //            print(error.localizedDescription)
    //            return []
    //        }
    //    }
    
    // 전체 데이터 가져오기
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // 특정 날짜 식단 가져오기
    func fetchMenu(searchDate: Date) -> Menu? {
        
        let fetchRequest = Menu.fetchRequest()
        let predicate = NSPredicate(format: "date >= %@ && date <= %@", Calendar.current.startOfDay(for: searchDate) as CVarArg, Calendar.current.startOfDay(for: searchDate + 86400) as CVarArg)
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        
        return menu.first
    }

    
    // Create - Menu & Food
    
    // Update - add Food
    
    // Delete - Food
    
    // Find - 이번달 중에 하트가 있는 데이터
}

