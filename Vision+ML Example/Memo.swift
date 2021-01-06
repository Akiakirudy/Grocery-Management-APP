//
//  Memo.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation


struct Memo {
    static let appName = "BANANA"
    static let segue_one = "name"
    static let segue_two = "consume"
    static let segue_three = "shoplist"
    static let cellIdentifier = "ReusableCell" //TableView to InputDataView
    static let cellIdentifierShop = "Shoplist" //TableView to ShoppingListView
    static let cellIdentifierFri = "CheckFri"  //TableView to ConsumptionView
    
    struct BrandColors {
        static let brown = "RedBrown"
        
    }
    struct Inventory_Entity {//TableView(ManageInventory)
        static let date = "date"
        static let item = "item"
        static let quantity = "qantity"
    }
    
    struct Purchased_Exense_Entity {//InputDataView
        static let payer = "payer"
        static let date = "date"
        static let item = "item"
        static let quantity = "qantity"
        static let tax = "tax"
    }
    
    struct Price_Dictionary {
        static let item = "item"
        static let price = "price"
    }
    
    struct Consumed_Entity {
        static let date = "date"
        static let item = "item"
        static let quantity = "qantity"
    }
}
