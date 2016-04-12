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
    
    func getMonth(monthNumber: Int) -> String {
        
        switch monthNumber {
        case 1:
            return month[0]
        case 2:
            return month[1]
        case 3:
            return month[2]
        case 4:
            return month[3]
        case 5:
            return month[4]
        case 6:
            return month[5]
        case 7:
            return month[6]
        case 8:
            return month[7]
        case 9:
            return month[8]
        case 10:
            return month[9]
        case 11:
            return month[10]
        case 12:
            return month[11]
        default:
            return "No Month"
        }
    }
    
//    func saveMonthAdHocExpense(monthName: String, adHoc: Double) {
//        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//        let entity = NSEntityDescription.entityForName(monthName, inManagedObjectContext: context)
//        let month = Month(entity: entity!, insertIntoManagedObjectContext: context)
//        
//        month.adHocExpense = adHoc
//        
//        context.insertObject(month)
//        
//        do {
//            try context.save()
//        } catch {
//            print("Could not save balance")
//        }
//
//    }
    
}