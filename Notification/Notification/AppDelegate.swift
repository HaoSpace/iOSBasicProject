//
//  AppDelegate.swift
//  Notification
//
//  Created by kooapps on 4/18/21.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        UNUserNotificationCenter.current().delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            if granted {
                center.setNotificationCategories(self.setCategories())
                self.sendNotification()
            }
            else {
                print("使用者未授權")
            }
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.categoryIdentifier)
        print(response.actionIdentifier)
        
        if (response.actionIdentifier == "a4") {
            if let r = response as? UNTextInputNotificationResponse {
                print(r.userText)
            }
        }
        
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Tesss"
        content.body = "hellooo"
        content.badge = 3
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "c1"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "myId", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
       
    }
    
    func setCategories() -> Set<UNNotificationCategory> {
        var set = Set<UNNotificationCategory>()
        let a1 = UNNotificationAction(identifier: "a1", title: "button1", options: [])
        let a2 = UNNotificationAction(identifier: "a2", title: "button2", options: [.foreground])
        let a3 = UNNotificationAction(identifier: "a3", title: "button3", options: [.destructive, .authenticationRequired])
        let a4 = UNTextInputNotificationAction(identifier: "a4", title: "reply", options: [])
        
        let c1 = UNNotificationCategory(identifier: "c1", actions: [a1,a2,a3,a4], intentIdentifiers: [], options: [])
        set.insert(c1)
        
        return set
    }


}

