//
//  ExpenseVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class ExpenseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!
    var expensiveType = ["Food","Rent","Utilities","Transportation","Other"]
    var expense: String!
    var startYear: Int!
    var startMonth: Int!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        expense = "Food"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print(adHoc)

        // Do any additional setup after loading the view.
        if adHoc == true {
            pickerView.hidden = true
            datePicker.hidden = false
            perMonthLabel.text = "Date Payment"
        } else {
            pickerView.hidden = false
            datePicker.hidden = true
            perMonthLabel.text = "Per Month"
        }
        
        getStartDate()

    }
    
    func getStartDate() {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //doing a fetch request of the collections entity
        let collectionRequest = NSFetchRequest(entityName: "Balance")
        do{
            let request = try context.executeFetchRequest(collectionRequest) as! [Balance]
            
            startYear = Int((request.first?.startYear)!)
            startMonth = Int((request.first?.startMonth)!)
            
        } catch {
            print("Couldn't get start date in IncomeVC")
        }
        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return expensiveType.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return expensiveType[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        expense = expensiveType[row]
    }

    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        if expenseTextField.text != nil && expenseTextField.text != "" {
            
            let enteredIncome = Double(expenseTextField.text!)!
            
            if adHoc == true {
                
                let month = Int(getMonth())!
                let year = Int(getYear())!
                
                saveMonthAdHoc(month, year: year, payment: enteredIncome)

                
                
            } else {
                 saveReccuringToCoreData(expense, payment: enteredIncome)
            }
        }
    }
    //-----------------------------------------------------------------------
    
    func saveMonthAdHoc(monthNumber: Int, year: Int, payment: Double) {
        if let loadedMonth = NSUserDefaults.standardUserDefaults().objectForKey("Month") as? NSData {
            if let monthArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedMonth) as? [Month] {
                
                if ((startYear+1) >= year) && (monthNumber < startMonth) {
                    showYearAlert()
                } else {
                    
                    for month in monthArray {
                        if month.month == monthNumber {
                            month.expense = payment
                            
                        }
                    }
                    
                    let monthData = NSKeyedArchiver.archivedDataWithRootObject(monthArray)
                    
                    NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
        }
    }

    
    //------------------------------------------------------------------------
    func showYearAlert() {
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: "Year is Wrong", message: "Please Select A Year within the Start Date", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
            let errorAlert: UIAlertView = UIAlertView()
            
            errorAlert.delegate = self
            
            errorAlert.title = "Oops"
            errorAlert.message = "Could not create account!"
            errorAlert.addButtonWithTitle("Dismiss")
            
            errorAlert.show()
        }
        
    }

    //------------------------------------------------------------------------
    func saveReccuringToCoreData(type: String, payment: Double) {
        print(type)
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        //fetchRequest.predicate = predicate
        
        do {
            let saveExpense = try context.executeFetchRequest(fetchRequest) as! [Expense]

            switch type {
            case "Food":
                ShareRecuring.shared.foodExpense = payment
                saveExpense.first?.food = payment
                break
            case "Rent":
                ShareRecuring.shared.rentExpense = payment
                saveExpense.first?.rent = payment
                break
            case "Utilities":
                ShareRecuring.shared.utilExpense = payment
                saveExpense.first?.util = payment
                break
            case "Transportation":
                ShareRecuring.shared.transportExpense = payment
                saveExpense.first?.transport = payment
                break
            case "Other":
                ShareRecuring.shared.otherExpense = payment
                saveExpense.first?.other = payment
                break
            default:
                break
            }
    
                       
            } catch {
            print("Didn't get entity from core data for income")
        }
        
        
        do {
            try context.save()
        } catch {
            print("Cant Save Balance in BalanceVC")
        }
}

    
    //-------------------------------------------------------------------------
    func getMonth() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        
        return strDate
        
    }
    
    
    func getYear() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        
        return strDate
        
    }
    //---------------------------------------------------------------------------



}
