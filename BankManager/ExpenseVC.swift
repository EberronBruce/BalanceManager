//
//  ExpenseVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ExpenseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!
    var expensiveType = ["Food","Rent","Utilities","Transportation","Other"]
    var expense: String!

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
                //Need adHoc
                
                
            } else {
                switch expense {
                    case "Food":
                        ShareRecuring.shared.foodExpense = enteredIncome
                    break
                    case "Rent":
                        ShareRecuring.shared.rentExpense = enteredIncome
                    break
                    case "Utilities":
                        ShareRecuring.shared.utilExpense = enteredIncome
                    break
                    case "Transportation":
                        ShareRecuring.shared.transportExpense = enteredIncome
                    break
                    case "Other":
                        ShareRecuring.shared.otherExpense = enteredIncome
                    break
                default:
                    break
                }
            }
        }

    }


}
