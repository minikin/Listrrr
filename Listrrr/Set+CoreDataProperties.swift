//
//  Set+CoreDataProperties.swift
//  Listrrr
//
//  Created by Sasha Minikin on 6/6/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Set {

    @NSManaged var createdAt: NSDate
    @NSManaged var setDescription: String
    @NSManaged var setID: String
    @NSManaged var setTitle: String
    @NSManaged var updatedAt: NSDate
    @NSManaged var lists: NSManagedObject

}
