//
//  AppDelegate.swift
//  StorageStructure
//
//  Created by kooapps on 4/19/21.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var db: OpaquePointer?
    lazy var dst = NSHomeDirectory() + "/Documents/mydb.sqlite"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // plist
        let fm = FileManager.default
//        let src = Bundle.main.path(forResource: "myPlist", ofType: "plist")
//        let dst = NSHomeDirectory() + "/Documents/myPlist.plist"
//
//        if !fm.fileExists(atPath: dst) {
//            try! fm.copyItem(atPath: src!, toPath: dst)
//        }
        
        //sqlite
        let src = Bundle.main.path(forResource: "mydb", ofType: "sqlite")
        
        if !fm.fileExists(atPath: dst) {
            try! fm.copyItem(atPath: src!, toPath: dst)
        }
        
        opendb()
        
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
    
    func opendb () {
        if sqlite3_open(dst, &db) == SQLITE_OK {
            print("sql success")
        } else {
            print("sql fail")
            db = nil
        }
    }
    
    func closedb () {
        if let db = db {
            sqlite3_close(db)
        }
    }


}

