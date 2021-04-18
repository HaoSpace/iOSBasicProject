//
//  ViewController.swift
//  Threading
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Main()
        //Concurrent()
        //Serial()
//        SleepA()
//        TimerA()
//        Semaphor()
//        OperationQueueA()
        OperationQueueB()
    }
    
    func Main () {
        DispatchQueue.main.async {
            Array(0...9).forEach {
                (i) in
                print(i)
            }
        }
        
        DispatchQueue.main.async {
            Array(10...19).forEach {
                (i) in
                print(i)
            }
        }
    }

    func Concurrent () {
        let q = DispatchQueue.global()
        q.sync {
            Array(0...9).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
        
        q.async {
            Array(10...19).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
    }
    
    func Serial() {
        let q1 = DispatchQueue(label: "q1")
        let q2 = DispatchQueue(label: "q2")
        
        q1.sync {
            Array(0...9).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
        
        q1.async {
            Array(10...19).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
        
        q2.async {
            Array(20...29).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
    }
    
    func SleepA () {
        DispatchQueue.global().async {
            NSLog("A")
            sleep(2)
            NSLog("B")
        }
    }
    
    func TimerA () {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            (timer) -> Void in
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm:ss"
                let whatTime = formatter.string(from: Date())
                
                print(whatTime)
        }
    }
    
    func Semaphor () {
        DispatchQueue.global().async {
            
            for i in 1...10 {
                let semaphor = DispatchSemaphore(value: 0)
                if i == 3 {
                    DispatchQueue.main.async(execute: {
                        self.showAlert(semaphor: semaphor)
                    })
                }
                else {
                    semaphor.signal()
                }
                
                _ = semaphor.wait(timeout: DispatchTime.distantFuture)
                print(i)
                sleep(1)
            }
        }
        
    }
    
    func showAlert (semaphor: DispatchSemaphore) {
        let alert = UIAlertController(title: "warning", message: "click confirm to continue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Comfirm", style: .default) {
            (action) in
            self.dismiss(animated: true, completion: nil)
            semaphor.signal()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func OperationQueueA () {
        let q = OperationQueue()
        
        q.addOperation {
            //Thread 1
            Array(0...9).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
        
        q.addOperation {
            //Thread 2
            Array(10...19).forEach {
                (i) in
                print(i)
                Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
            }
        }
    }
    
    func OperationQueueB () {
        let q1 = MyOperation(1...9)
        let q2 = MyOperation(10...19)
        
        OperationQueue().addOperations([q1, q2], waitUntilFinished: true)
        print("Done")
                    
    }
}

