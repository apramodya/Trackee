//
//  SummaryViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

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
    var realm = try! Realm()
    var transactions: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // buttons
        prevMonth.roundedOnLeftButton()
        nextMonth.roundedOnRightButton()
        
        showingMonth = getCurrentMonth()
        showingYear = getCurrentYear()
        
        // get values for month, income, expences and balance
        getValues()
        
        // display values for month, income, expences and balance
        displayValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showingMonth = getCurrentMonth()
        showingYear = getCurrentYear()
        getValues()
        displayValues()
    }
    
    @IBAction func gotoPrevMonth(_ sender: Any) {
        showingMonth = getPrevMonth()
        month.text = months[showingMonth-1]
        getValues()
        displayValues()
    }
    
    @IBAction func gotoNextMonth(_ sender: Any) {
        showingMonth = getNextMonth()
        month.text = months[showingMonth-1]
        getValues()
        displayValues()
    }
}

extension SummaryViewController {
    
    // MARK: - Supporting functions
    
    func getValues() {
        // initialize variable values
        income = getIncome(forMonth: showingMonth)
        expences = getExpences(forMonth: showingMonth)
        balance = getBalance(forMonth: showingMonth)
    }
    
    func displayValues() {
        // currency formatter
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        // display month label
        month.text = months[showingMonth-1]
        
        // display income, expences and balance
        incomeLbl.text = formatter.string(from: income as NSNumber)
        expencesLbl.text = formatter.string(from: expences as NSNumber)
        balanceLbl.text = formatter.string(from: balance as NSNumber)
    }
    
    func loadTransactions(forMonth month: Int, type: String) -> Results<Item> {
        let beginOfMonth = Date().startOfMonth(month: showingMonth, year: showingYear)
        let endOfMonth = Date().endOfMonth(month: showingMonth, year: showingYear)
        
        return realm.objects(Item.self).filter("type == %@", type)
            .filter("date BETWEEN %@", [beginOfMonth, endOfMonth])
    }
    
    func getIncome(forMonth month: Int) -> Double {
        let trans = loadTransactions(forMonth: month, type: types[0])
        var amnt = 0.0
        for transaction in trans {
            amnt += transaction.amount
        }
        let income = amnt
        
        return income
    }
    
    func getExpences(forMonth month: Int) -> Double {
        let trans = loadTransactions(forMonth: month, type: types[1])
        var amnt = 0.0
        for transaction in trans {
            amnt += transaction.amount
        }
        let expences = amnt
        
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
