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
        let predicate = NSPredicate(format: "date >= %@ && date < %@",
                                    startOfDay as CVarArg,
                                    endOfDay as CVarArg)
        
        let fetchRequest = Menu.fetchRequest()
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        return menu.first
    }
    
    // Fetch - 특정 날짜 식단의 heart state 가져오기
    func fetchHeart(date: Date) -> Bool {
        
        let menu = fetchMenu(searchDate: date)
        return menu?.isHeart ?? false
    }
    
    // 모든 식단 중에서 isHeart인 식단 가져오기
    func fetchHeartMenu() -> [Menu] {
        
        let predicate = NSPredicate(format: "isHeart == true")
        
        let fetchRequest = Menu.fetchRequest()
        fetchRequest.predicate = predicate
        
        let menu: [Menu] = fetch(request: fetchRequest)
        
        return menu
    }
    
    // Create - Menu & Food
    func createMenu(date: Date) -> Menu {
        
        let menu = Menu(context: context)
        menu.date = date
        save()
        
        return menu
    }
    
    private func createFood(image: Data?, name: String, category: Int32) -> Food {
        
        let food = Food(context: context)
        food.imageData = image
        food.name = name
        food.categoryValue = category
        
        return food
    }
    
    // Update - add Food
    func add(image: Data?, name: String, category: Int32, to menu: Menu) {
        
        let food = createFood(image: image, name: name, category: category)
        menu.addToFoods(food)
        save()
    }
    
    // Update - heart state
    func updateHeartState(menu: Menu, state: Bool) {
        
        menu.isHeart = state
        save()
    }
}

