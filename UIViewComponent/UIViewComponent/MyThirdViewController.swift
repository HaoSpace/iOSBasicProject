//
//  MyThirdViewController.swift
//  UIViewComponent
//
//  Created by kooapps on 4/15/21.
//

import UIKit

class MyThirdViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var toolbar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("按鈕", for: .normal)
        
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        for tmp in view.subviews {
            if tmp is UITextField {
                (tmp as! UITextField).inputAccessoryView = toolbar
            }
        }
    }
    
    @IBAction func testButton(_ sender: Any) {
        for tmp in view.subviews {
            if tmp is UITextField, tmp.isFirstResponder{
                (tmp as! UITextField).text = "hello"
                break
            }
        }
    }
    
    @IBAction func donButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
    }
    
    @IBAction func displayViewToggle(_ sender: UISwitch) {
        bottomConstraint.constant = sender.isOn ? 0 : -128
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        print("hello")
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
