//
//  ViewController.swift
//  Hello
//
//  Created by kooapps on 4/13/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func onClick(_ sender: Any) {
        label.text = "hello world"
    }
    
    @IBAction func showVcWithoutSegue(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "newVC")
        show(vc!, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_vc_to_myvc"
        {
            let vc = segue.destination as! MyViewController
            vc.str = "hello"
        }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        if segue.identifier == "unwind_vc_to_myvc" {
            let vc = segue.source as! MyViewController
            if let str = vc.str
            {
                print(str)
            }
        }
    }
}

