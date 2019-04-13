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
    
    // variables
    var realm = try! Realm()
    var transactions: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadTransactions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func loadTransactions() {
        transactions = realm.objects(Item.self)
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
