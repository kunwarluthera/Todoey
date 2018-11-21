//
//  Item.swift
//  Todoey
//
//  Created by Kunwar Luthera on 11/20/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    @objc dynamic var dateCreated: Date?

    
}
