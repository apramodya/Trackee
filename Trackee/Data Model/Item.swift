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
    @objc dynamic var type = ""
    @objc dynamic var date : Date = Date()
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var note: String = ""
    @objc dynamic var category: String = ""
//    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
