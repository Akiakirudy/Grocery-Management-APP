//
//  ConsumptionViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/13/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit
import RealmSwift

class ConsumptionViewController: UIViewController {
    
    var consumeName = ""
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageIngri: UIImageView!
    
    var img : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemName = consumeName.components(separatedBy: "\n")
        let first_item = itemName[0].components(separatedBy: ") ")
        itemLabel.text = first_item[1]
        imageIngri.image = img
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        
        
    }
    
    @IBAction func Update(_ sender: Any) {
        var index = 1
        while index > 0 {
            let item = itemLabel.text!
            let quanti_num_int : Int? = Int(quantity.text!)
            let realm = try! Realm()
            
            let consumption = Inventory()
            consumption.item = item
            consumption.quantity = quanti_num_int!
            
            //item(Apple)がinventory内にあれば、itemのquantity を新しいデータとして更新する。
            if realm.object(ofType: Inventory.self, forPrimaryKey: consumption.item) != nil {
                let toBeUpdatedRecords = realm.objects(Inventory.self).filter("item = '\(item)'")
                try! realm.write {
                    print("ここにいるよ")
                    for element in toBeUpdatedRecords{
                        let exnum = element.quantity
                        print(exnum)
                        let nownum = quanti_num_int!
                        print(nownum)
                        element.quantity = exnum - nownum
                        print(element.quantity)
                    }
                }
            //なければAlertだす。
            } else {
                print("Alert")
            }
            index = index - 1
        }
    }
}
