//
//  AppDelegate.swift
//  Todo
//
//  Created by Oleg Ten on 26.06.2018.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        //RealmDataBase Location
        print(Realm.Configuration.defaultConfiguration.fileURL)
         //RealmDataBase Location
    
        
        do {
            let realm = try Realm()
            
        }catch{
            
            print("realm error")
        }
        
        return true
    }

   

}

