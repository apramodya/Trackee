//
//  Category.swift
//  Trackee
//
//  Created by Pramodya Abeysinghe on 7/4/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var categoryID = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""

    override static func primaryKey() -> String? {
        return "categoryID"
    }
    
    convenience init(categoryID: String, name: String, type: String) {
        self.init()
        self.categoryID = categoryID
        self.name = name
        self.type = type
    }
    
    convenience init(name: String, type: String) {
        self.init()
        self.name = name
        self.type = type
    }
}
