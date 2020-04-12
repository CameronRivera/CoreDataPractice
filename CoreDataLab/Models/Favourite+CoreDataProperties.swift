//
//  Favourite+CoreDataProperties.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var image: Data?
    @NSManaged public var tags: String?
    @NSManaged public var id: String?
    @NSManaged public var user: User?

}
