//
//  Month+CoreDataProperties.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Month {

    @NSManaged var name: String?
    @NSManaged var year: NSNumber?
    @NSManaged var currentBalance: NSNumber?
    @NSManaged var expense: Expense?
    @NSManaged var income: Income?

}
