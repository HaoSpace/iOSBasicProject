//
//  ViewController.swift
//  OtherControllerProject
//
//  Created by kooapps on 4/16/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popoverCtrl = segue.destination.popoverPresentationController
        let modalCtrl = segue.destination.presentationController
        
        if sender is UIButton, let vc = popoverCtrl {
            vc.sourceRect = (sender as! UIButton).bounds
            vc.delegate = self
        }
        
        if sender is UIButton, let vc = modalCtrl {
            vc.delegate = self
        }
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @IBAction func OnAlertClick(_ sender: UIButton) {
        let alertController = UIAlertController(title: "標題", message: "風格", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: "確定", style: .default) { (action) in
            
        }
        
        alertController.addAction(okAction)
        
        //set popover for ipad when actionSheet
        alertController.modalPresentationStyle = .popover
        let pop = alertController.popoverPresentationController
        pop?.sourceView = sender
        pop?.sourceRect = sender.bounds
        
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func OnAlertInputClick(_ sender: Any) {
        let alert = UIAlertController(title: "登入", message: "請輸入登入資訊", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "登入", style: .default){(action) in
            let uid = alert.textFields![0].text
            let pwd = alert.textFields![1].text
            
            print("Uid: \(uid!), Pwd: \(pwd!)")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField() {
            (textField) in
            textField.placeholder = "Email"
        }
        alert.addTextField() {
            (textField) in
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func OmActivityClick(_ sender: Any) {
        let string = "hello"
        let image = UIImage(named: "1.png")
        
        let vc = UIActivityViewController(activityItems: [string, image!], applicationActivities: nil)
        
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func OnSafariClick(_ sender: Any) {
        let vc = SFSafariViewController(url: URL(string: "https://www.apple.com")!)
        show(vc, sender: self)
    }
}

