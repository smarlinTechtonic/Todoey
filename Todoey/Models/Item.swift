//
//  Item.swift
//  Todoey
//
//  Created by Sonali Marlin on 10/30/19.
//  Copyright © 2019 Sonali Marlin. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: CategoryList.self, property: "items")
}
