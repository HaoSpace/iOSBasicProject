//
//  MyObserver.swift
//  Notification
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class MyObserver: NSObject {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object != nil {
            let n = (object! as AnyObject).value(forKeyPath: keyPath!)
            print("dn: \(n!)")
        }
    }
}
