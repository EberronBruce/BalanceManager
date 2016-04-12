//
//  Month.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/12/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation

class Month: NSObject, NSCoding {
    
    private var _adHocIncome: Double!
    private var _adHocExpense: Double!
    private var _year: Int!
    private var _month: Int!
    private var _name: String!
    
    var income: Double {
        get {
            
            return _adHocIncome
        }
        set(income) {
            _adHocIncome = income
        }
    }
    
    var month: Int {
        get {
            return _month
        }
    }
    
    var adHocExpense: Double {
        get {
            return _adHocExpense
        }
        set(expense) {
            _adHocExpense = expense
        }

    }
    
    var year: Int {
        get {
            return _year
        }
        set(date) {
            _year = date
        }
    }
    
    var name: String {
        get {
            return _name
        }
    }
    
    
    init(month: Int, year: Int) {
        let setMonth = SetMonthState()
        _name = setMonth.getMonth(month)
        _month = month
        _year = year
        _adHocIncome = 0.0
        _adHocExpense = 0.0
    }

    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._year = aDecoder.decodeObjectForKey("year") as? Int
        self._month = aDecoder.decodeObjectForKey("month") as? Int
        self._name = aDecoder.decodeObjectForKey("name") as? String
        self._adHocExpense = aDecoder.decodeObjectForKey("adHocExpense") as? Double
        self._adHocIncome = aDecoder.decodeObjectForKey("adHocIncome") as? Double
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._year, forKey: "year")
        aCoder.encodeObject(self._month, forKey: "month")
        aCoder.encodeObject(self._name, forKey: "name")
        aCoder.encodeObject(self._adHocExpense, forKey: "adHocExpense")
        aCoder.encodeObject(self._adHocIncome, forKey: "adHocIncome")

    }

}