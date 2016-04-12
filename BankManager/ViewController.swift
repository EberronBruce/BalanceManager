//
//  ViewController.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let didRun = NSUserDefaults.standardUserDefaults().valueForKey("FirstRun") as? Bool {
            print("It did run yeah!!")
            print(didRun)
        } else {
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            
            let year = components.year
            
            var months = [Month]()
            
            
            for i in 1...12 {
                let month = Month(month: i, year: year)
                months.append(month)
            }
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstRun")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let monthData = NSKeyedArchiver.archivedDataWithRootObject(months)
            
            NSUserDefaults.standardUserDefaults().setObject(monthData, forKey: "Month")
            NSUserDefaults.standardUserDefaults().synchronize()

        }

//        
//        if let loadedMonth = NSUserDefaults.standardUserDefaults().objectForKey("Month") as? NSData {
//            
//            if let monthArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedMonth) as? [Month] {
//                
//                for month in monthArray {
//                    print(month.name)
//                }
//                
//            }
//            
//        }

        
        
        
        
        
        
    }

}

