//
//  CategoryTableViewCell.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 8/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(category: Category) {
        categoryName.text = category.name
        
        if category.type == "Income" {
            categoryName.textColor = color1
        } else {
            categoryName.textColor = color2
        }
    }
    
}
