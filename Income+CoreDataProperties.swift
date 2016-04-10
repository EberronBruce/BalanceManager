//
//  Income+CoreDataProperties.swift
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

extension Income {

    @NSManaged var salary: NSNumber?
    @NSManaged var investments: NSNumber?
    @NSManaged var adHoc: NSNumber?
    @NSManaged var month: Month?

}
