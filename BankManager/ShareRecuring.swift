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
    }
    
    var utilExpense: Double {
        get {
            return _utilExpense
        }
    }
    
    var transportExpense: Double {
        get {
            return _transportExpense
        }
    }
    
    var otherExpense: Double {
        get {
            
            return _otherExpense
        }
    }
    
    var salaryIncome: Double {
        get {
            return _salaryIncome
        }
    }
    
    var investmentIncome: Double {
        get {
            return _investmentIncome
        }
    }
}