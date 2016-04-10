//
//  IncomeVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class IncomeVC: UIViewController {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var incomeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

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

    
    @IBAction func saveButtonPressed(sender: AnyObject) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
