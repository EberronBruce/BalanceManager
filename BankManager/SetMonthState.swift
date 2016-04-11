//
//  SetMonthState.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SetMonthState {
    
    //Need to think through this more
    
    
    let month = ["January","February","March","April","May","June","July","August","September","October","November", "December"]
    
    func setMonth(monthNumber: Int) {
        
        switch monthNumber {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        case 11:
            break
        case 12:
            break
        default:
            break
        }
    }
    
    func saveMonthAdHocExpense(monthName: String, adHoc: Double) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName(monthName, inManagedObjectContext: context)
        let month = Month(entity: entity!, insertIntoManagedObjectContext: context)
        
        month.adHocExpense = adHoc
        
        context.insertObject(month)
        
        do {
            try context.save()
        } catch {
            print("Could not save balance")
        }

    }
    
    func getMonth(monthNumber: Int) {
        
        switch monthNumber {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        case 10:
            break
        case 11:
            break
        case 12:
            break
        default:
            break
        }

    }
}