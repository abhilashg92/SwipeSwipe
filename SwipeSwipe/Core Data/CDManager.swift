//
//  CDManager.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 16/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation
import CoreData

class CDManager {
    
    
    private static var  instance : CDManager?
    
    //Private initializer
    class func shared() -> CDManager {
        
        guard let shared = instance else {
            instance = CDManager()
            return instance!
        }
        return shared
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SwipeSwipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error")
            }
        })
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func addToFavourite(profile:Result) {
        let entity = NSEntityDescription.entity(forEntityName: "Favourite",
                                                in: backgroundContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: backgroundContext)
        
        user.setValue("\(profile.name.title)\(profile.name.first ) \(profile.name.last)", forKeyPath: "name")
        user.setValue(profile.phone, forKeyPath: "phone")
        user.setValue(profile.location.city, forKeyPath: "location")
        user.setValue(profile.picture.large, forKeyPath: "imageUrl")

        do{
            try backgroundContext.save()
        } catch {
            
        }
    }
    
    func getFavourite(completion: @escaping ([Favourite]?, String?) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        do {
            if let results = try persistentContainer.viewContext.fetch(fetchRequest) as? [Favourite] {
                
                completion(results,nil)

            } else{
                completion(nil,"No Profile Found")

                return
            }
        } catch {
             completion(nil,"Fetch Error")
            return
        }
    }
    
}
