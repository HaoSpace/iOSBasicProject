//
//  MyReceiver.swift
//  Notification
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class MyReceiver: NSObject {

    @objc func receiveNotification (_ notification: Notification) {
        if let n = notification.object as? Int {
            if  notification.name.rawValue == "MyKey" {
                print(n)
            }
        }
    }
}
