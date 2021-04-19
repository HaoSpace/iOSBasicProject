//
//  ViewController.swift
//  FileManagement
//
//  Created by kooapps on 4/19/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "1.png")
        let myObj = MyObject(image: image!, text: "wewe")
        let url = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/save.data")
        
        //save
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: myObj, requiringSecureCoding: false)
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let obj = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! MyObject
            
//            imageView.image = obj.image
//            label.text = obj.text
        } catch {
            print(error.localizedDescription)
        }
        
    }


}

