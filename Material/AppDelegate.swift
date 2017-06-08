//
//  AppDelegate.swift
//  Material
//
//  Created by Noirozr on 16/2/3.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit
import SQLite
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let data: AnyObject = UserDefaults.standard.object(forKey: "DSP") as AnyObject {
            
            print("哈利路亚")
            print(data)
            
        } else {
            let dData = [0, 0, 0, 0, 0, 0, 0, 0]
            UserDefaults.standard.set(dData, forKey: "DSP")
        }
        
        if let data: AnyObject = UserDefaults.standard.object(forKey: "ASP") as AnyObject {
            
            print("哈利路亚 NI")
            print(data)
            
        } else {
            let aData = [0, 0, 0, 0, 0]
            UserDefaults.standard.set(aData, forKey: "ASP")
        }
        
        
        
        
//        do {
//            guard let path = NSBundle.mainBundle().pathForResource("MATDB", ofType: "sqlite") else {
//                print("path wrong")
//                return true
//            }
//            let db = try Connection(path)
//            
//            let ds = Table("Algorithm")
//            let id = Expression<Int64>("ColumnId")
//            let name = Expression<String?>("Name")
//            
//            for data in try db.prepare(ds) {
//                print("id: \(data[id]), name: \(data[name])")
//                // id: 1, name: Optional("Alice"), email: alice@mac.com
//            }
//
//
//        } catch {
//           print(error)
//        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

