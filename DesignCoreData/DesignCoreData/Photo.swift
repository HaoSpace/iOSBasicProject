//
//  Photo.swift
//  DesignCoreData
//
//  Created by kooapps on 4/22/21.
//

import UIKit

class Photo: NSObject, NSCoding {
    
    var image: UIImage?
    var title: String?
    
    override init() {
        
    }
    
    func encode(with coder: NSCoder) {
        let imageData = image!.pngData()
        coder.encode(imageData, forKey: "image")
        coder.encode(title, forKey: "title")
    }
    
    required init?(coder: NSCoder) {
        image = UIImage(data: coder.decodeObject(forKey: "image") as! Data)
        title = coder.decodeObject(forKey: "title") as? String
    }
    

}
