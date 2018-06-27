//
//  Item.swift
//  Todo
//
//  Created by Oleg Ten on 26.06.2018.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable{//or Codable = Encodable, Decodable
    var title : String = ""
    var done : Bool = false
    
}
