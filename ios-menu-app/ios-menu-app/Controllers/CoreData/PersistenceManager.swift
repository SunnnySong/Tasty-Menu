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
    private let calendar = Calendar(identifier: .gregorian)
    
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
    
    // Fetch - 전체 데이터 가져오기
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try self.context.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // Fetch - 특정 날짜 식단 가져오기
    func fetchMenu(searchDate: Date) -> Menu? {
        
        let startOfDay = calendar.startOfDay(for: searchDate)
        let endOfDay = calendar.startOfDay(for: searchDate + 86400)
        let predicate = NSPredicate(format: "date >= %@ && date <= %@",
                                    startOfDay as CVarArg,
                                    endOfDay as CVarArg)
        
        let fetchRequest = Menu.fetchRequest()
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        
        return menu.first
    }

    // Fetch - 한 달 동안의 식단 중에 isHeart가 true인 식단 가져오기
    func fetchHeartMenuInMonth(baseDate: Date) -> [Menu] {
        
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDate))
        let lastDayOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfMonth!)
        let predicate = NSPredicate(format: "isHeart == true AND date >= %@ && date <= %@",
                                    firstDayOfMonth! as NSDate,
                                    lastDayOfMonth! as NSDate)
        
        let fetchRequest = Menu.fetchRequest()
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        
        return menu
    }
    
    // 모든 식단 중에서 isHeart인 식단 가져오기
    func fetchMenu() -> [Menu] {
        
        let predicate = NSPredicate(format: "isHeart == true")
        
        let fetchRequest = Menu.fetchRequest()
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        
        return menu
    }
    
    
    // Create - Menu & Food
    
    // Update - add Food
    
    // Update - heart state
    func updateHeartState(menu: Menu, state: Bool) {
        
        menu.isHeart = state
        save()
    }
    
    // Delete - Food
    
    // Find - 이번달 중에 하트가 있는 데이터
}

