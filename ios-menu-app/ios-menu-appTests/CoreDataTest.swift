//
//  CoreDataTest.swift
//  ios-menu-appTests
//
//  Created by Sunny on 2023/05/18.
//

import XCTest
import CoreData
@testable import ios_menu_app

final class CoreDataTest: XCTestCase {
    
    var sut: String!
    
    // appDelegate
    var appDelegate: AppDelegate!
    // Context 생성
    var context: NSManagedObjectContext!
    
    // Entity 생성
    var menuEntity: NSEntityDescription!
    var foodEntity: NSEntityDescription!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        context = appDelegate.persistentContainer.viewContext
        
        menuEntity = NSEntityDescription.entity(forEntityName: "Menu", in: context)
        foodEntity = NSEntityDescription.entity(forEntityName: "Food", in: context)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        
        menuEntity = nil
        foodEntity = nil
        try super.tearDownWithError()
    }
    
    func test_Persistent_Container에_ManagedObjectModel_추가하기() {
        
        // ver1. obejct 추가
        let food1 = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
        food1.name = "열무국수"
        
        try! context.save()
        
        // ver2. ManagedObjectModel을 만들어서 추가하기
        let foodObjectModel = NSManagedObject(entity: foodEntity, insertInto: context)
        let food2 = DailyFood(image: nil, name: "떡볶이", category: .korean)
        foodObjectModel.setValue(food2.name, forKey: "name")
        
        try! context.save()
        
        // ver3. ManagedObjectModel을 subclassing로 인스턴스 생성해서 저장하기
        let food3 = Food(context: context)
        food3.name = "순대"
        
        try! context.save()
        
        var foods = try! context.fetch(Food.fetchRequest())
        // foods에서 index로 접근해 값 변경 가능
        foods[1].category = .korean
        
        foods.forEach { food in
            print(food.name, food.category)
        }
    }
    
    /* - Menu -> Food : Menu는 Food를 속성으로 갖고 있다.
     - Menu Entity의 ManagedObjectModel에서 foods에 음식을 추가한다면, 자동으로 Food Entity에 추가가 될까?
     
     - 정답 : 가능
     */
    func test_relationship_MenuEntity추가시_FoodEntity에_자동추가되는지() {
        
        // Menu ManagedObjectModel instance 생성
        let menu = Menu(context: context)
        menu.date = Date()
        
        // Food ManagedObjectModel instance 생성
        let food1 = Food(context: context)
        food1.name = "양념게장"
        let food2 = Food(context: context)
        food2.name = "간장게장"
        
        // ver1) Menu ManagedObjectModel에 relationship인 food 추가할 수 있는 메서드 제공
        menu.addToFoods(food1)
        menu.addToFoods(food2)
        
        // menu에 food 추가하고 난 뒤 context에 저장
        try! context.save()
        
        // ver2) menu.foods를 NSMutableOrderedSet으로 변환한 뒤, add 메서드로 추가
        
        let fetchedMenus = try! context.fetch(Menu.fetchRequest())
        fetchedMenus.forEach { fetchedMenu in
            print(fetchedMenu.foods)
        }
        
        let fetchedFoods = try! context.fetch(Food.fetchRequest())
        for fetchedFood in fetchedFoods {
            print("Food: \(fetchedFood.name ?? "")")
        }
    }
    
    /*
     - Menu Entity에서 foods 중 하나의 food의 데이터를 업데이트하면, Food Entity에서 자동을 업데이트가 가능한가?
     - 가능
     */
    func test_MenuEntity에서_food의_데이터업데이트시_FoodEntity에서_업데이트가되는가() {
        
        let fetchedMenus = try! context.fetch(Menu.fetchRequest())

        // 오늘 날짜와 동일한 Menu 가져오기
        guard let filteredMenus = fetchedMenus.filter { menu in
            guard let menuDate = menu.date else {
                return false
            }
            
            // 한달 내 모든 menu data 가져오기
//            return Calendar.current.isDate(menuDate, equalTo: Date(), toGranularity: .month)
            // 오늘과 동일한 날짜인지 확인
            return Calendar.current.isDate(menuDate, inSameDayAs: Date())
        }.first else { return }
        
        // 특정 인덱스로 접근해 이름 변경
        let firstFood = filteredMenus.foods?.object(at: 0) as! Food
        firstFood.name = "잡채"
        
        let fetchedFoods = try! context.fetch(Food.fetchRequest())
        for fetchedFood in fetchedFoods {
            print("Food: \(fetchedFood.name ?? "")")
        }
    }
    
    func test_CoreData에_Enum저장하기() {
        
        let food = Food(context: context)
        food.category = .japanese
        
        let fetchedFoods = try! context.fetch(Food.fetchRequest())
        for fetchedFood in fetchedFoods {
            print("Food: \(fetchedFood.category)")
        }
    }
}

