//
//  Balance+CoreDataProperties.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/11/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Balance {

    @NSManaged var totalBalance: NSNumber?
    @NSManaged var startYear: NSNumber?
    @NSManaged var startMonth: NSNumber?

}
