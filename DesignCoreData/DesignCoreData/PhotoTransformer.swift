//
//  PhotoTransformer.swift
//  DesignCoreData
//
//  Created by kooapps on 4/22/21.
//

import UIKit

class PhotoTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value else {
            return nil
        }
        
        return try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value as! Data)
    }
}
