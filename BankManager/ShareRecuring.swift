//
//  ShareRecuring.swift
//  BankManager
//
//  Created by Bruce Burgess on 4/10/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import Foundation

class ShareRecuring {
    static let shared = ShareRecuring()
    
    private var _foodExpense = 0.0
    private var _rentExpense = 0.0
    private var _utilExpense = 0.0
    private var _transportExpense = 0.0
    private var _otherExpense = 0.0
    
    private var _salaryIncome = 0.0
    private var _investmentIncome = 0.0
    
    private var _startDateMonth = 1
    private var _startDateYear = 2016
    
    var startDateMonth: Int {
        get{
            return _startDateMonth
        }
        set(month) {
            _startDateMonth = month
        }
    }
    
    var startDateYear: Int {
        get {
            return _startDateYear
        }
        set(year) {
            _startDateYear = year
        }
    }
    
    var foodExpense: Double {
        get {
            return _foodExpense
        }
        set(expense) {
            _foodExpense = expense
        }
    }
    
    
    var rentExpense: Double {
        get {
            return _rentExpense
        }
        set(expense) {
            _rentExpense = expense
        }
    }
    
    var utilExpense: Double {
        get {
            return _utilExpense
        }
        set(expense) {
            _utilExpense = expense
        }
    }
    
    var transportExpense: Double {
        get {
            return _transportExpense
        }
        set(expense) {
            _transportExpense = expense
        }
    }
    
    var otherExpense: Double {
        get {
            
            return _otherExpense
        }
        set(expense) {
            _otherExpense = expense
        }
    }
    
    var salaryIncome: Double {
        get {
            return _salaryIncome
        }
        set(expense) {
            _salaryIncome = expense
        }
    }
    
    var investmentIncome: Double {
        get {
            return _investmentIncome
        }
        set(expense) {
            _investmentIncome = expense
        }
    }
}