//
//  AppDelegate.swift
//  Chaya
//
//  Created by MI on 4/17/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("isDataPreloaded : \(UserDefaults.standard.bool(forKey: "isDataPreloaded"))")
        
        if UserDefaults.standard.bool(forKey: "isDataPreloaded") != true{
            
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
                if granted {
                    print("We have permission.")
                }else{
                    print("Permission Denied.")
                }
            }
            
//            loadOnboarding()
            preloadData()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    func preloadData(){
        
        let realm = try! Realm()
        // cat 1
        let catagory1 = Catagory()
        catagory1.id = 1
        catagory1.name = "Sleep"
        // cat 2
        let catagory2 = Catagory()
        catagory2.id = 2
        catagory2.name = "Eat"
        // cat 3
        let catagory3 = Catagory()
        catagory3.id = 3
        catagory3.name = "Medical"
        // cat 4
        let catagory4 = Catagory()
        catagory4.id = 4
        catagory4.name = "Meditation"
        // cat 5
        let catagory5 = Catagory()
        catagory5.id = 5
        catagory5.name = "Workout"
        // cat 4
        let catagory6 = Catagory()
        catagory6.id = 6
        catagory6.name = "Travel"
        
        let catagories: [Catagory] = [catagory1,catagory2,catagory3,catagory4,catagory5,catagory6]
        for item in catagories{
            
            do{
                try realm.write {
                    realm.add(item)
                    print("Data preloaded.")
                }
            }catch{
                print("Error preloading Data.")
            }
        }
        UserDefaults.standard.set(true, forKey: "isDataPreloaded")
        
    }


}

