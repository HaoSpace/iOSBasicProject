//
//  MyObject.swift
//  Notification
//
//  Created by kooapps on 4/18/21.
//

import UIKit

@objc
protocol MyObjectDelegate: NSObjectProtocol {
    func returnAnswer(object: MyObject, answer: Float)
    @objc optional func returnError(error: NSError?)
}

class MyObject: NSObject {
    var delegate: MyObjectDelegate?
    
    func divide(_ value: Float, by byValue: Float) {
        if byValue != 0 {
            delegate? .returnAnswer(object: self, answer: value / byValue)
        }
        
        if delegate?.responds(to: #selector(MyObjectDelegate.returnError(error:))) != nil {
            var error: NSError? = nil
            
            if byValue == 0 {
                error = NSError(domain: "Dom", code: 1, userInfo: [NSLocalizedDescriptionKey: "\(value)/\(byValue) 分母不為零"])
            }
            
            delegate?.returnError?(error: error)
        }
    }

}
