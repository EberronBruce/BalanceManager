//
//  ExpenseVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ExpenseVC: UIViewController {
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var adHoc: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
