//
//  MyViewController.swift
//  OtherControllerProject
//
//  Created by kooapps on 4/16/21.
//

import UIKit

class MyViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popoverCtrl = segue.destination.popoverPresentationController
        
        if sender is UIBarButtonItem {
            popoverCtrl?.barButtonItem = sender as? UIBarButtonItem
        }
        
        popoverCtrl?.delegate = self
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
