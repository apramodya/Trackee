//
//  Item.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var itemID = UUID().uuidString
    @objc dynamic var type = ""
    @objc dynamic var date : Date = Date()
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var note: String = ""
    @objc dynamic var category: String = ""
    
    override static func primaryKey() -> String? {
        return "itemID"
    }
    
    convenience init(type: String, date: Date, amount: Double, note: String, category: String) {
        self.init()
        self.type = type
        self.date = date
        self.amount = amount
        self.note = note
        self.category = category
    }
    
    convenience init(itemID: String, type: String, date: Date, amount: Double, note: String, category: String) {
        self.init()
        self.itemID = itemID
        self.type = type
        self.date = date
        self.amount = amount
        self.note = note
        self.category = category
    }
}
