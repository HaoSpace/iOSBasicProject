//
//  MyObject.swift
//  FileManagement
//
//  Created by kooapps on 4/19/21.
//

import UIKit

class MyObject: NSObject, NSCoding {
    
    var image: UIImage
    var text: String?
    
    init(image: UIImage, text: String?) {
        self.image = image
        self.text = text
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(text, forKey: "text")
        coder.encode(image.pngData(), forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        text = coder.decodeObject(forKey: "text") as? String
        let data = coder.decodeObject(forKey: "image") as! Data
        
        image = UIImage(data: data)!
    }
    

}
