//
//  SceneDelegate.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        // MARK: MockData-CoreData
//        let context = PersistenceManager.shared.context
        
//        let menu = Menu(context: context)
//        menu.date = .today
//        menu.isHeart = true
//
//        let food1 = Food(context: context)
//        food1.name = "양념게장"
//        let food2 = Food(context: context)
//        food2.name = "간장게장"
//
//        menu.addToFoods(food1)
//        menu.addToFoods(food2)
//
//        PersistenceManager.shared.save()
        
//        let searchDateComponents = DateComponents(year: 2023, month: 5, day: 20)
//        
//        let menu2 = Menu(context: context)
//        menu2.date = Calendar.current.date(from: searchDateComponents)
//        menu2.isHeart = true
//        
//        let food3 = Food(context: context)
//        food3.name = "맥도날드"
//        food3.categoryValue = 1
//        let food4 = Food(context: context)
//        food4.name = "롯데리아"
//        
//        menu2.addToFoods(food3)
//        menu2.addToFoods(food4)
        
//        PersistenceManager.shared.save()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

