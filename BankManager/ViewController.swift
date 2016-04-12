//
//  ViewController.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let didRun = NSUserDefaults.standardUserDefaults().valueForKey("FirstRun") as? Bool {
            print("It did run yeah!!")
            print(didRun)
            
            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            //doing a fetch request of the collections entity
            let request = NSFetchRequest(entityName: "Balance")
            do{
                let results = try context.executeFetchRequest(request) as! [Balance]
                
                print(results[0].startYear)
                
                
            } catch {
                
            }

            
        } else {

            
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            
            let year = components.year
            let month = components.month
            
            saveDefaultMonths(year)
            saveDefaultBalance(month, year: year)
            saveDefaultExpense()
            saveDefaultIncome()
         
        }

    }
    
    func saveDefaultIncome() {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Income", inManagedObjectContext: context)
        let income = Income(entity: entity!, insertIntoManagedObjectContext: context)
        
        income.investments = 0.0
        income.salary = 0.0
        
        context.insertObject(income)
        
        do {
            try context.save()
        } catch {
            print("Could not save balance")
        }
        

    }
    
    func saveDefaultExpense() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Expense", inManagedObjectContext: context)
        let expense = Expense(entity: entity!, insertIntoManagedObjectContext: context)
        
        expense.food = 0.0
        expense.rent = 0.0
        expense.transport = 0.0
        expense.util = 0.0
        expense.other = 0.0
        
        context.insertObject(expense)
        
        do {
            try context.save()
        } catch {
            print("Could not save balance")
        }
        

    }
    
    func saveDefaultMonths(year: Int) {
   
        var months = [Month]()
        
        
        for i in 1...12 {
            let month = Month(month: i, year: year)
            months.append(month)
        }
        
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstRun")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let monthData = NSKeyedArchiver.archivedDataWithRootObject(months)
        
        NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    func saveDefaultBalance(month: Int, year: Int) {
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Balance", inManagedObjectContext: context)
        let balance = Balance(entity: entity!, insertIntoManagedObjectContext: context)
        
        balance.startMonth = month
        balance.startYear = year
        balance.totalBalance = 0.0
        
        context.insertObject(balance)
        
        do {
            try context.save()
        } catch {
            print("Could not save balance")
        }

    }

}

