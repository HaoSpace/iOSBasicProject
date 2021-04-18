//
//  ViewController.swift
//  Notification
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class ViewController: UIViewController, MyObjectDelegate {
    
    
    @objc let receiver = MyReceiver()
    
    @objc dynamic var dn = 0;
    let observer = MyObserver()
    
    let myObj = MyObject()
    
    var n = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Receiver
        NotificationCenter.default.addObserver(receiver, selector: #selector(receiver.receiveNotification(_:)), name: Notification.Name("MyKey"), object: nil)
        
        //Observer
        addObserver(observer, forKeyPath: "dn", options: .new, context: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: Notification.Name("MyKey"), object: Int(n))
        n = n + 1
        dn = dn + 1
    }
    
    func returnAnswer(object: MyObject, answer: Float) {
        print(answer)
    }



}

