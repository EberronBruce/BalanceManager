//
//  BalanceVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData

class BalanceVC: UIViewController {
    @IBOutlet weak var balanceTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        balanceTextField.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if balanceTextField.text != nil && balanceTextField.text != "" {

            let enteredBalance = Double(balanceTextField.text!)!
            print(enteredBalance)
            
            let month = Int(getMonth())!
            let year = Int(getYear())!
            
            print(month)
            print(year)
            
            saveBalanceIntoCoreData(enteredBalance, month: month, year: year)
            self.navigationController?.popViewControllerAnimated(true)
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
    

    func saveBalanceIntoCoreData(enterNumber: Double, month: Int, year: Int) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //let predicate = NSPredicate(format: "totalBalance == %@",  "totalBalance")
        let fetchRequest = NSFetchRequest(entityName: "Balance")
        //fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try context.executeFetchRequest(fetchRequest) as! [Balance]
            fetchedEntities.first?.totalBalance = enterNumber
            fetchedEntities.first?.startYear = year
            fetchedEntities.first?.startMonth = month
            // ... Update additional properties with new values
        } catch {
            print("Didn't get entity from core data for balance")
        }
        
        do {
            try context.save()
        } catch {
            print("Cant Save Balance in BalanceVC")
        }
        
    }

}
