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
    
    var expenses: [Double] = []
    var incomes: [Double] = []
    var previousBalance: [Double] = []
    var currentBalance: [Double] = []
    var monthNames: [String] = []
    var months: [Month] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let didRun = NSUserDefaults.standardUserDefaults().valueForKey("FirstRun") as? Bool {
            print("It did run yeah!!")
            print(didRun)
            
//            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//            //doing a fetch request of the collections entity
//            let request = NSFetchRequest(entityName: "Income")
//            do{
//                let results = try context.executeFetchRequest(request) as! [Income]
//                
//                print(results.first?.investments)
//                print(results.first?.salary)
//                
//                
//            } catch {
//                
//            }
            
//            if let loadedMonth = NSUserDefaults.standardUserDefaults().objectForKey("Month") as? NSData {
//                if let monthArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedMonth) as? [Month] {
//
//                        for month in monthArray {
//                            print(month.name)
//                            print(month.year)
//                    }
//                }
//            }
//            
            

            
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
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstRun")
            NSUserDefaults.standardUserDefaults().synchronize()
         
        }

    }
    
    override func viewWillAppear(animated: Bool) {
//        if let didRun = NSUserDefaults.standardUserDefaults().valueForKey("FirstRun") as? Bool {
//            let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
//            //doing a fetch request of the collections entity
//            let request = NSFetchRequest(entityName: "Balance")
//            do{
//                if let results = try context.executeFetchRequest(request) as? [Balance] {
//                    let number = Double((results[0].totalBalance)!)
//                    
//                    
//                    print("View Will Appear: \(number) ")
//                }
//                
//                
//                
//                
//            } catch {
//                
//            }
//        }

    }
    
    func saveDefaultIncome() {
        print("Save Default Income")
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
        print("Save Default Expense")
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
        print("Save Default Months")
        var months = [Month]()
        for i in 1...12 {
            let month = Month(month: i, year: year)
            months.append(month)
        }

        
        let monthData = NSKeyedArchiver.archivedDataWithRootObject(months)
        
        NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    
    func saveDefaultBalance(month: Int, year: Int) {
        print("Save Default Balance")
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
//--------------------------------------------------------------------------------
    @IBAction func reportsPressed(sender: AnyObject) {
        setData()
        
        performSegueWithIdentifier("Reports", sender: nil)
    }
    
    func setData() {
        self.expenses = []
        self.incomes = []
        self.previousBalance = []
        self.currentBalance = []
        self.monthNames = []
        self.months = []

        
        let startMonth = getStartMonth()
        let startYear = getStartYear()
        
        if startMonth == -1 || startYear == -1 {
            fatalError("Must need a valid month or year")
        } else {
            
            setFirstElementForTable(startMonth, startYear: startYear)
            calculateCurrentBalance()
        
        }
    }
//------------------------------------------------------------------------------
    func setFirstElementForTable(startMonth: Int, startYear: Int) {
        if let loadedMonth = NSUserDefaults.standardUserDefaults().objectForKey("Month") as? NSData {
            if let monthArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedMonth) as? [Month] {
                
                let start = startMonth - 1

                var finish = 0
                for x in 0...11 {
                    let month = start + x
                    if month < 12 {
                        print("\(monthArray[month].name) \(monthArray[month].year)")
                        monthNames.append("\(monthArray[month].name) \(monthArray[month].year)")
                        months.append(monthArray[month])
                    } else {
                        if monthArray[finish].year == startYear {
                            monthArray[finish].year += 1
                        }
                        print("\(monthArray[finish].name) \(monthArray[finish].year)")
                        monthNames.append("\(monthArray[finish].name) \(monthArray[finish].year)")
                        months.append(monthArray[finish])
                        finish += 1
                    }
                
                }
                
                let monthData = NSKeyedArchiver.archivedDataWithRootObject(monthArray)
                
                NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
                NSUserDefaults.standardUserDefaults().synchronize()

                
            }
        }
  
    }
    
    func calculateCurrentBalance() {
        let income = getTotalRecurringIncomes()
        let expense = getTotalRecurringExpenses()
        let startBalance = getStartBalance()
        
        if income == -1 || expense == -1 || startBalance == -1 {
            print("We have a serious problem")
        } else {
            var currentIndex = 0
            for month in months {
                if month == months[0] {
                    previousBalance.append(startBalance)
                    let currentMoney = startBalance + income + month.income - expense - month.expense
                    month.currentBalance = currentMoney
                    currentBalance.append(currentMoney)
                } else {
                    previousBalance.append(currentBalance[currentIndex - 1])
                    let currentMoney = currentBalance[currentIndex - 1] + income + month.income - expense - month.expense
                    month.currentBalance = currentMoney
                    currentBalance.append(currentMoney)
                }
                currentIndex += 1
            }
        }
        
       
    }
    
    func getTotalRecurringIncomes() -> Double {
        var totalIncome: Double
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Income")
        
        do {
            let fetchedIncome = try context.executeFetchRequest(fetchRequest) as! [Income]
            
            let salary = Double((fetchedIncome.first?.salary)!)
            let investment = Double((fetchedIncome.first?.investments)!)
            
            totalIncome = salary + investment
            
            return totalIncome
            
        } catch {
            print("Didn't get start month from core data for income")
        }
        
        
        return -1.0
    }
    
    func getTotalRecurringExpenses() -> Double {
        var totalExpense: Double
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        
        do {
            let fetchedExpense = try context.executeFetchRequest(fetchRequest) as! [Expense]
            
            let food = Double((fetchedExpense.first?.food)!)
            let rent = Double((fetchedExpense.first?.rent)!)
            let util = Double((fetchedExpense.first?.util)!)
            let transport = Double((fetchedExpense.first?.transport)!)
            let other = Double((fetchedExpense.first?.other)!)
            
            totalExpense = food + rent + util + transport + other
            
            return totalExpense
            
        } catch {
            print("Didn't get start month from core data for expense")
        }
        
        
        return -1.0

    }

    func getStartBalance() -> Double {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Balance")
        //fetchRequest.predicate = predicate
        
        do {
            let fetchedBalance = try context.executeFetchRequest(fetchRequest) as! [Balance]
            if let balance = fetchedBalance.first?.totalBalance {
                return Double(balance)
            }
            
        } catch {
            print("Didn't get start month from core data for balance")
        }
        
        
        return -1.0
    }



    func getStartMonth() -> Int {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Balance")
        //fetchRequest.predicate = predicate
        
        do {
            let fetchedMonth = try context.executeFetchRequest(fetchRequest) as! [Balance]
            if let month = fetchedMonth.first?.startMonth {
                return Int(month)
            }
            
        } catch {
            print("Didn't get start month from core data for balance")
        }
        
      
        return -1
    }
    
    func getStartYear() -> Int {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Balance")
        //fetchRequest.predicate = predicate
        
        do {
            let fetchedMonth = try context.executeFetchRequest(fetchRequest) as! [Balance]
            if let year = fetchedMonth.first?.startYear {
                return Int(year)
            }
            
        } catch {
            print("Didn't get start year from core data for balance")
        }
        
        
        return -1
    }
    
    //-------------------------------------------------------------------------------------------

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Reports" {
            let vc = segue.destinationViewController as! MonthTableVC
            vc.monthNames = self.monthNames
            vc.months = self.months
            vc.currentBalance = self.currentBalance
            vc.previousBalance = self.previousBalance
        }
    }
    
}

