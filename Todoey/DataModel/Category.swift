//
//  Category.swift
//  Todoey
//
//  Created by Kunwar Luthera on 11/20/18.
//  Copyright © 2018 Kunwar Luthera. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
