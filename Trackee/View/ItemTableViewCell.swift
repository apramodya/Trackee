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
    @IBOutlet weak var dateDisplayed: UILabel!
    
    // variables
    let formatter = NumberFormatter()
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // currency formatter
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        
        // date formatter
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
    }

    func configureCell(transaction: Item) {
        itemName.text = transaction.note
        itemCategory.text = transaction.category
        itemAmount.text = formatter.string(from: transaction.amount as NSNumber)
        dateDisplayed.text = dateFormatter.string(from: transaction.date)
        
        if transaction.type == "Income" {
            itemCategory.textColor = color1
        } else {
            itemCategory.textColor = color2
        }
    }

}
