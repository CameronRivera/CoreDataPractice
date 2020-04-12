//
//  CoreDataManager.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

protocol CoreDataManagerDelegate: AnyObject {
    func updatedFavourites(_ coreDataManager: CoreDataManager)
}

import UIKit

class CoreDataManager{
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]()
    private var favourites = [Favourite]()
    weak var delegate: CoreDataManagerDelegate?
    
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createUser(_ name: String) throws -> User {
        let user = User(entity: User.entity(), insertInto: context)
        
        user.name = name
        
        do {
            try context.save()
        } catch {
            throw error
        }
        return user
    }
    
    public func createFavourite(_ tags: String,_ id: String, _ imageData: Data,_ user: User) throws -> Favourite{
        let favourite = Favourite(entity: Favourite.entity(), insertInto: context)
        favourite.tags = tags
        favourite.id = id
        favourite.image = imageData
        favourite.user = user
        
        do {
            try context.save()
            delegate?.updatedFavourites(self)
        } catch {
            throw error
        }
        return favourite
    }
    
    public func fetchUsers() throws -> [User]{
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            throw error
        }
        return users
    }
    
    public func fetchFavourites(_ userName: String) throws -> [Favourite] {
        
        do{
            favourites = try context.fetch(Favourite.fetchRequest())
        } catch {
            throw error
        }

        return favourites.filter{$0.user?.name == userName}
    }
    
    public func deleteFavourite(_ favourite: Favourite) throws {
        
        context.delete(favourite)
        
        do {
            try context.save()
            delegate?.updatedFavourites(self)
        } catch {
            throw error
        }
        
    }
}
