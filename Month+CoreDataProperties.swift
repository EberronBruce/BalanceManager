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

    @NSManaged var year: NSNumber?
    @NSManaged var currentBalance: NSNumber?
    @NSManaged var foodExpense: NSNumber?
    @NSManaged var rentExpense: NSNumber?
    @NSManaged var transportExpense: NSNumber?
    @NSManaged var utilExpense: NSNumber?
    @NSManaged var adHocExpense: NSNumber?
    @NSManaged var otherExpense: NSNumber?
    @NSManaged var salaryIncome: NSNumber?
    @NSManaged var investmentIncome: NSNumber?
    @NSManaged var adHocIncome: NSNumber?
    @NSManaged var previousBalance: NSNumber?
    @NSManaged var monthNumber: NSNumber?

}
