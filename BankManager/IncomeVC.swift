//
//  IncomeVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class IncomeVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!
    let incomeType = ["Salary","Investments"]
    var income: String?

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
            let month = Int(getMonth())
            let year = Int(getYear())
            
            if adHoc == true {
                //Need adHoc
                
                
            } else {
                if income == "Salary" {
                    ShareRecuring.shared.salaryIncome = enteredIncome
                } else  if income == "Investments" {
                    ShareRecuring.shared.investmentIncome = enteredIncome
                }
            }
            
            print(month)
            print(year)
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
