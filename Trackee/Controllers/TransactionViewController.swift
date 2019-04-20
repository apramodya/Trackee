//
//  TransactionViewController.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var prevMonth: UIButton!
    @IBOutlet weak var nextMonth: UIButton!
    
    
    // variables
    var realm = try! Realm()
    var transactions: Results<Item>!
    var showingMonth: Int = 0
    var showingYear: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // buttons
        prevMonth.roundedOnLeftButton()
        nextMonth.roundedOnRightButton()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        showingMonth = getCurrentMonth()
        showingYear = getCurrentYear()
        
        // display month label
        monthLbl.text = months[showingMonth-1]

        loadTransactions()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showingMonth = getCurrentMonth()
        showingYear = getCurrentYear()
        monthLbl.text = months[showingMonth-1]
        loadTransactions()
        tableView.reloadData()
    }
    
    @IBAction func prevBtnPressed(_ sender: Any) {
        showingMonth = getPrevMonth()
        monthLbl.text = months[showingMonth-1]
        loadTransactions()
        tableView.reloadData()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        showingMonth = getNextMonth()
        monthLbl.text = months[showingMonth-1]
        loadTransactions()
        tableView.reloadData()
    }
    
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ItemTableViewCell {
            cell.configureCell(transaction: transactions[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }    
}

extension TransactionViewController {
    func loadTransactions() {
        let beginOfMonth = Date().startOfMonth(month: showingMonth, year: showingYear)
        let endOfMonth = Date().endOfMonth(month: showingMonth, year: showingYear)
        
        transactions = realm.objects(Item.self)
            .filter("date BETWEEN %@", [beginOfMonth, endOfMonth])
            .sorted(byKeyPath: "date", ascending: false)
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
