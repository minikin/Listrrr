//
//  CoreDataStack.swift
//  Listrrr
//
//  Created by Sasha Minikin on 6/2/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//
//  Abstract:
//  This object contains the cadre of Core Data objects known as the “stack”:
//  the context, the model, the persistent store and the persistent store coordinator.
//  The stack installs a database that already has data in it on first launch.

import Foundation
import CoreData

class CoreDataStack {
  
  // MARK: - Core Data stack
  
  let managedObjectModelName: String
  
  // MARK: - Initialisation
  
  required init(modelName:String) {
    
    managedObjectModelName = modelName
    
  }
  
  /*
   The model file is located within the main bundle. Then an instance of NSManagedObjectModel is created using this URL
   
   The managed object model for the application. This property is not optional.
   It is a fatal error for the application not to be able to find and load its model.
   
   */
  private lazy var managedObjectModel : NSManagedObjectModel = {
    
    let modelURL = NSBundle.mainBundle().URLForResource(self.managedObjectModelName, withExtension: "momd")!
    
    return  NSManagedObjectModel(contentsOfURL: modelURL)!
    
  }()
  
  /*
   
   The directory the application uses to store the Core Data store file.
   This code uses a directory named "me.minikin.Listrrr" in the application's documents Application Support directory.
   
   */
  
  private var applicationDocumentDirectory : NSURL = {
    
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    
    return urls[urls.endIndex-1]
    
  }()
  
  /*
   
   The persistent store coordinator for the application. This implementation creates and returns a coordinator,
   having added the store for the application to it.
   This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
   
   */
  
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator =  {
    
    let errorPointer : NSErrorPointer = nil
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    
    let pathComponent = "\(self.managedObjectModelName).sqlite"
    
    let url = self.applicationDocumentDirectory.URLByAppendingPathComponent(pathComponent)
    
    do {
      try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
    } catch {
      print("Unresolved error adding persistent store: \(error)")
    }
    
    return coordinator
    
  }()
  
  
  /*
   
   Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
   This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
   
   */
  
  lazy var mainQueueContext : NSManagedObjectContext = {
    
    let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    moc.persistentStoreCoordinator = self.persistentStoreCoordinator
    
    moc.name = "Main Queue Context (UI Context)"
    
    return moc
    
  }()
  
  
  // MARK: - Core Data Saving support
  
  func saveChanges () throws {
    
    print("saveChanges")
    
    var error : ErrorType?
    
    mainQueueContext.performBlockAndWait() {
      
      if self.mainQueueContext.hasChanges {
        
        do {
          
          try self.mainQueueContext.save()
          
        } catch let saveError {
          
          error = saveError
        }
      }
    }
    
    if let error = error {
      throw error
    }
  }
  
}

