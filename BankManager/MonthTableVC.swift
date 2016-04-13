//
//  MonthTableVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class MonthTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var expenses: [Double] = []
    var incomes: [Double] = []
    var previousBalance: [Double] = []
    var currentBalance: [Double] = []
    var monthNames: [String] = []
    var months: [Month] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ReportsCell") as? ReportsCell {
            cell.textLabel?.text = monthNames[indexPath.row]
            return cell
        } else {
            
            let cell = ReportsCell()
            cell.textLabel?.text = monthNames[indexPath.row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(monthNames[indexPath.row])
//        print("Previous Balance: \(previousBalance[indexPath.row])")
//        print("Current Balance: \(currentBalance[indexPath.row])")
        
        let array = [months[indexPath.row], previousBalance[indexPath.row], currentBalance[indexPath.row]]
        
        performSegueWithIdentifier("ReportSegue", sender: array)
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "ReportSegue" {
            let vc = segue.destinationViewController as! ReportVC
            let data = sender as! NSArray
            
            vc.month = data[0] as! Month
            vc.previousBalance = data[1] as! Double
            vc.currentBalance = data[2] as! Double
        }
        // Pass the selected object to the new view controller.
    }
    

}
