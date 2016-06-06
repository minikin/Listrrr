//
//  Word+CoreDataProperties.swift
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

extension Word {

    @NSManaged var createdAt: NSDate
    @NSManaged var updatedAt: NSDate
    @NSManaged var wordID: String
    @NSManaged var wordName: String
    @NSManaged var lists: NSManagedObject

}
