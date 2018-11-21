//
//  AppDelegate.swift
//  Todoey
//
//  Created by Kunwar Luthera on 10/23/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        }catch {
            print("Error initializing \(error)")
        }
        return true
    }
   
}

