//
//  MyViewController.swift
//  Hello
//
//  Created by kooapps on 4/13/21.
//

import UIKit

class MyViewController: UIViewController {
    var str: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let str = str {
            print(str)
        }
    }
    
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
