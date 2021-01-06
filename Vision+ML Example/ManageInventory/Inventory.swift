//
//  Data.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Inventory: Object {
    @objc dynamic var item : String = ""
    @objc dynamic var quantity : Int = 0
    @objc dynamic var date : Date = Date()
    
    override static func primaryKey() -> String? {
            return "item"
    }
}
