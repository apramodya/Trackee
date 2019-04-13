//
//  AppDelegate.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 6/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            debugPrint("Error in Realm \(error)")
        }
        
        return true
    }


}

