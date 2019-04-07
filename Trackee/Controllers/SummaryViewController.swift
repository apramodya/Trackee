//
//  SummaryViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var prevMonth: UIButton!
    @IBOutlet weak var nextMonth: UIButton!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var expencesLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    // variables
    var showingMonth: Int = 0
    var showingYear: Int = 0
    var income: Double = 0.0
    var expences: Double = 0.0
    var balance: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initialize variable values
        showingMonth = getCurrentMonth()
        showingYear = getCurrentYear()
        income = getIncome(forMonth: showingMonth)
        expences = getExpences(forMonth: showingMonth)
        balance = getBalance(forMonth: showingMonth)
        
        // currency formatter
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "si_LK")
        formatter.numberStyle = .currency
        
        // display month label
        month.text = months[showingMonth-1]
        
        // display income, expences and balance
        incomeLbl.text = formatter.string(from: income as NSNumber)
        expencesLbl.text = formatter.string(from: expences as NSNumber)
        balanceLbl.text = formatter.string(from: balance as NSNumber)
        
    }
    
    @IBAction func gotoPrevMonth(_ sender: Any) {
        showingMonth = getPrevMonth()
        month.text = months[showingMonth-1]
        print(showingYear)
    }
    
    @IBAction func gotoNextMonth(_ sender: Any) {
        showingMonth = getNextMonth()
        month.text = months[showingMonth-1]
        print(showingYear)
    }
}

extension SummaryViewController {
    
    // MARK: - Supporting functions
    
    func getIncome(forMonth month: Int) -> Double {
        let income = 10000.00
        
        return income
    }
    
    func getExpences(forMonth month: Int) -> Double {
        let expences = 3500.00
        
        return expences
    }
    
    func getBalance(forMonth month: Int) -> Double {
        let income = getIncome(forMonth: month)
        let expences = getExpences(forMonth: month)
        let balance = income - expences
        
        return balance
    }
    
    func getCurrentMonth() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        
        return month
    }
    
    func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        return year
    }
    
    func getPrevMonth() -> Int {
        var month = showingMonth
        month -= 1
        
        if month == 0 {
            month = 12
            showingYear -= 1
        }
        
        return month
    }
    
    func getNextMonth() -> Int {
        var month = showingMonth
        month += 1
        
        if month == 13 {
            month = 1
            showingYear += 1
        }
        
        return month
    }
    
}