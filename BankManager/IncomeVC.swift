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
    var selectDate: String?
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
        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MM-yyyy"
//        let strDate = dateFormatter.stringFromDate(datePicker.date)
//        self.selectDate = strDate
        
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        let month = getMonth()
        let year = getYear()
        
        print(month)
        print(year)
        print(income)
        
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
