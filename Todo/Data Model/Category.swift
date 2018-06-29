//
//  Category.swift
//  Todo
//
//  Created by Oleg Ten on 6/29/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
