//
//  ViewController.swift
//  ViewControllerProject
//
//  Created by kooapps on 4/15/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet var blurEffect: UIVisualEffectView!
    @IBOutlet weak var label1: UILabel!
    var tmp: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        //first view controller
        let backItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        let image = UIImage(named: "7.png")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        //every view controller
//        let image = UIImage(named: "5.png")?.withRenderingMode(.alwaysOriginal)
//        let backItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = backItem
        
        label1.text = tmp
    }

    @IBAction func showMyView(_ sender: Any) {
        blurEffect.frame = view.frame
        view.addSubview(blurEffect)
        
        myView.center = view.center
        myView.layer.cornerRadius = 10
        view.addSubview(myView)
    }
    
    @IBAction func closeMyView(_ sender: Any) {
        blurEffect.removeFromSuperview()
        myView.removeFromSuperview()
    }
}

