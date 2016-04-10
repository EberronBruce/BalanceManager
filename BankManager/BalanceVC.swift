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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if balanceTextField.text != nil && balanceTextField.text != "" {

            let enteredBalance = Double(balanceTextField.text!)!
            print(enteredBalance)
            
            saveBalanceIntoCoreData(enteredBalance)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func saveBalanceIntoCoreData(enterNumber: Double) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Balance", inManagedObjectContext: context)
        let balance = Balance(entity: entity!, insertIntoManagedObjectContext: context)
        
        balance.totalBalance = enterNumber
        
        context.insertObject(balance)
        
        do {
            try context.save()
        } catch {
            print("Could not save balance")
        }
    
    }

}
