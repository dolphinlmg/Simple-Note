//
//  CoreDataManager.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/19.
//  Copyright © 2020 이민규. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // Singleton
    static let shared = CoreDataManager()
    
    private let appDelegate: AppDelegate?
    let managedContext: NSManagedObjectContext?
    var fetchRequest: NSFetchRequest<Notes>?
    
    private init() {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.managedContext = self.appDelegate?.persistentContainer.viewContext
        self.fetchRequest = nil
    }
    
    // save current objects
    func saveContext() {
        guard let delegate = self.appDelegate else {
            return
        }
        
        delegate.saveContext()
    }
    
    // returns entity by name
    func getEntity(entityName name: String) -> NSEntityDescription? {
        guard let context = self.managedContext else {
            return nil
        }
        
        return NSEntityDescription.entity(forEntityName: name, in: context)
    }
    
    // returns new object in entity by name
    func getNewObject(entityName name: String) -> Notes? {
        guard let context = self.managedContext,
            let entity = self.getEntity(entityName: name) else {
            return nil
        }
        
        return Notes(entity: entity, insertInto: context)
    }
    
    // returns fetch request of Notes
    func getFetchRequest(entityName name: String) -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: name)
    }
    
    // returns objects by entity name
    func fetchObject(entityName name: String) -> [Notes]? {
        if self.fetchRequest == nil {
            self.fetchRequest = self.getFetchRequest(entityName: name)
            if self.fetchRequest == nil {
                return nil
            }
        }
        
        var ret: [Notes]?
        
        do {
            try ret = self.managedContext?.fetch(self.fetchRequest!)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        return ret
    }
    
    // delete object in context
    func deleteObject(obj: Notes) {
        guard let context = self.managedContext else {
            return
        }
        
        context.delete(obj)
        self.saveContext()
    }
    
}

