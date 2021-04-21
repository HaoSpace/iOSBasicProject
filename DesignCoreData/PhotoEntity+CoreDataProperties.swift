//
//  PhotoEntity+CoreDataProperties.swift
//  DesignCoreData
//
//  Created by kooapps on 4/22/21.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var photoObject: NSObject?

}

extension PhotoEntity : Identifiable {

}
