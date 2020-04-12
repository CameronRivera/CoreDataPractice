//
//  User+CoreDataProperties.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var favourites: NSSet?

}

// MARK: Generated accessors for favourites
extension User {

    @objc(addFavouritesObject:)
    @NSManaged public func addToFavourites(_ value: Favourite)

    @objc(removeFavouritesObject:)
    @NSManaged public func removeFromFavourites(_ value: Favourite)

    @objc(addFavourites:)
    @NSManaged public func addToFavourites(_ values: NSSet)

    @objc(removeFavourites:)
    @NSManaged public func removeFromFavourites(_ values: NSSet)

}
