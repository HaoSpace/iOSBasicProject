//
//  NSLayoutAnchorTestVC.swift
//  Layout
//
//  Created by kooapps on 4/13/21.
//

import UIKit

class NSLayoutAnchorTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
        label.backgroundColor = UIColor.lightGray
        label.text = "hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.heightAnchor.constraint(equalToConstant: 22).isActive = true;
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true;
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
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
