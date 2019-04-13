//
//  ItemTableViewCell.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 13/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    // IBOutlets
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemAmount: UILabel!
    
    // variables
    let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // currency formatter
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
    }

    func configureCell(transaction: Item) {
        itemName.text = transaction.note
        itemCategory.text = transaction.category
        itemAmount.text = formatter.string(from: transaction.amount as NSNumber)
    }

}
