//
//  Item.swift
//  Todo
//
//  Created by Oleg Ten on 6/29/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var toParent = LinkingObjects(fromType: Category.self, property: "items")
    
}
