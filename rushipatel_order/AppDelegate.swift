//
//  AppDelegate.swift
//  rushipatel_order
//
//  Created by Rushi Patel on 2021-02-15.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    //Core Data Stack
    
    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoModel")
        
        container.loadPersistentStores(completionHandler: { (storeDecription, error) in
            if let error = error as NSError?{
                print("Unresolved error \(error)")
            }
        });
        return container
    }()
    func saveContext(){
        let context = persistentContainer.viewContext
        
        if context.hasChanges{
            do{
                try context.save()
            } catch{
                let nserror = error as NSError
                print("Unresolved error \(nserror)")
            }
        }
    }
}

