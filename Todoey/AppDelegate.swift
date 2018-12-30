//
//  AppDelegate.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-11-24.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      //  print(Realm.Configuration.defaultConfiguration.fileURL)
      
        
        do {
            let _ = try Realm()
           
          
        } catch {
            print("error initializing new realm \(error)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }


    
   




}

