//
//  KindVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class KindIncomeVC: UIViewController {
    
    var adHoc = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func adHocButtonPressed(sender: AnyObject) {
        adHoc = true
        performSegueWithIdentifier("IncomeSegue", sender: adHoc)
    }
    
    @IBAction func recurringButtonPressed(sender: AnyObject) {
        adHoc = false
        performSegueWithIdentifier("IncomeSegue", sender: adHoc)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "IncomeSegue" {
            let vc = segue.destinationViewController as? IncomeVC
            vc?.adHoc = sender as? Bool
        }
        // Pass the selected object to the new view controller.
    }
    

}
