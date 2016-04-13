//
//  ReportVC.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit
import CoreData
import Charts

class ReportVC: UIViewController {
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var previousBalanceLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    
    var month: Month!
    var previousBalance: Double!
    var currentBalance: Double!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let expense = getExpenses()
        
        let cost = expense.expenses
        let type = expense.type
        
        if cost.count > 0 && type.count > 0 {
            setChart(type, values: cost)
        } else {
            print("Nothing in the array, that is a problem")
        }

    }
    
    func getExpenses() -> (expenses: [Double], type: [String]) {
        
        var cost: [Double] = []
        var type: [String] = []
        
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Expense")
        
        do {
            let fetchedExpense = try context.executeFetchRequest(fetchRequest) as! [Expense]
            
            let food = Double((fetchedExpense.first?.food)!)
            cost.append(food)
            type.append("Food")
            let rent = Double((fetchedExpense.first?.rent)!)
            cost.append(rent)
            type.append("Rent")
            let util = Double((fetchedExpense.first?.util)!)
            cost.append(util)
            type.append("Util")
            let transport = Double((fetchedExpense.first?.transport)!)
            cost.append(transport)
            type.append("Transport")
            let other = Double((fetchedExpense.first?.other)!)
            cost.append(other)
            type.append("Other")
            
            let adhoc = month.expense
            cost.append(adhoc)
            type.append("Adhoc")
            
            return(cost, type)

            
        } catch {
            print("Didn't get start month from core data for expense")
        }
        
        let emptyArray : [Double] = []
        let emptyStringArray: [String] = []

        return(emptyArray, emptyStringArray)
    }
    
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
    }

}
