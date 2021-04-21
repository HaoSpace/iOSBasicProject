//
//  Car+CoreDataProperties.swift
//  DesignCoreData
//
//  Created by kooapps on 4/21/21.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var plate: String?
    @NSManaged public var belongto: UserData?

}

extension Car : Identifiable {

}
