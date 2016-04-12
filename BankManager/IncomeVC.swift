//
//  IncomeVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class IncomeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!
    let incomeType = ["Salary","Investments"]
    var income: String?
    var startYear: Int!
    var startMonth: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        income = incomeType.first
        
        if adHoc == true {
            pickerView.hidden = true
            datePicker.hidden = false
            perMonthLabel.text = "Date Recieve"
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        incomeTextField.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return incomeType.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return incomeType[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        income = incomeType[row]
    }
    
    
    
    @IBAction func datePickerValueChange(sender: AnyObject) {
        
        
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        if incomeTextField.text != nil && incomeTextField.text != "" {
            
            let enteredIncome = Double(incomeTextField.text!)!
            
            
            if adHoc == true {
               
                let month = Int(getMonth())!
                let year = Int(getYear())!
                
                saveMonthAdHoc(month, year: year, payment: enteredIncome)
                
            } else {
                if income == "Salary" {
                    ShareRecuring.shared.salaryIncome = enteredIncome
                    saveReccuringToCoreData(income!, payment: enteredIncome)
                } else  if income == "Investments" {
                    ShareRecuring.shared.investmentIncome = enteredIncome
                    saveReccuringToCoreData(income!, payment: enteredIncome)
                }
            }
            
        }
    }
    
    func saveMonthAdHoc(monthNumber: Int, year: Int, payment: Double) {
        if let loadedMonth = NSUserDefaults.standardUserDefaults().objectForKey("Month") as? NSData {
            if let monthArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedMonth) as? [Month] {
                
                if ((startYear+1) >= year) && (monthNumber < startMonth) {
                    showYearAlert()
                } else {
                    
                    for month in monthArray {
                        if month.month == monthNumber {
                            month.income = payment
                            
                        }
                    }
                    
                    let monthData = NSKeyedArchiver.archivedDataWithRootObject(monthArray)
                    
                    NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
            }
        }
    }
    
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
    
    
    func saveReccuringToCoreData(type: String, payment: Double) {
        print(type)
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Income")
        //fetchRequest.predicate = predicate

        do {
            let saveIncome = try context.executeFetchRequest(fetchRequest) as! [Income]
            
            if type == "Salary" {
                saveIncome.first?.salary = payment
            } else if type == "Investments" {
                saveIncome.first?.investments = payment
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
    
}

