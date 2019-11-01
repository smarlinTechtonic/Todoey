//
//  CategoryList.swift
//  Todoey
//
//  Created by Sonali Marlin on 10/30/19.
//  Copyright © 2019 Sonali Marlin. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryList: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
