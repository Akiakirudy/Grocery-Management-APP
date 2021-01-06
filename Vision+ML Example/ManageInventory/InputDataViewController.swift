//
//  InputDataViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 11/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import UIKit
import RealmSwift

class InputDataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIDocumentInteractionControllerDelegate {
    
    let realm = try! Realm()
    
    var finalName = ""
    var realmList = ""
    var newInventory = ""
    var img : UIImage!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tax: UITextField!
    @IBOutlet var payerlabel : UILabel!
    @IBOutlet var foodimage : UIImageView!

    var itemlabel = UILabel()
    var PayerList = ["Akira", "Shun"]
    var image_food : UIImage!
    var quanti_num = ""
    var itemName = [""]
    var shoplist = ""
    var elements = [""]
    var documentInteraction: UIDocumentInteractionController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
       
        image_food = UIImage(named: "food")

        let itemName = finalName.components(separatedBy: "\n")
        let first_item = itemName[0].components(separatedBy: ") ")
        nameLabel.text = first_item[1]
        foodimage.image = img
        foodimage.layer.cornerRadius = foodimage.frame.size.width * 0.1
        foodimage.clipsToBounds = true
        
    }
    //データの保存
    func saveInventoryData(model: Inventory, realm: Realm){
        try! realm.write {
            realm.add(model)
            
            
        }
    }
//    func savePurchasedData(model: Purchased, realm: Realm){
//        try! realm.write {
//            realm.add(model)}
    
    //ボタンたちdataのpickerたちを設定
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return PayerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return PayerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payerlabel.text = PayerList[row]
        
    }
    
    //すべてのデータをボタンをおしたらRealmに保存する
    @IBAction func WriteRealm(_ sender: Any) {
        //dateをstringに変換しlistとしてすべてのデータをまとめる
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        let item = nameLabel.text!
        let payername : String = payerlabel.text!
        let quanti_num = quantity.text!
        let quanti_num_int : Int? = Int(quantity.text!)
        //let tax_num : Int = Int()
        let strdate = formatter.string(from: datePicker.date)
        let list = [payername, strdate, item, quanti_num]
       
       
        
        //Realm 設置
        //Tell Realm to use this new configuration object for the default Realm
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        //realm のinventory Entityから(item: , quantity: , date: , tax)を受け継ぐ
        let newInventory = Inventory()
        newInventory.item = list[2]
        newInventory.quantity = quanti_num_int!
        newInventory.date = datePicker.date
        
        //Purchased entity から(Payer, date, item, price, taxをいれる)
//        let newpurchased = Purchased()
//        newpurchased.payer = list[0]
//        newpurchased.date = datePicker.date
//        newInventory.item = list[2]
//        //price のdictionary からitem検索でとってくる//excel file をdictionary にしてしまう
//        newpurchased.tax = tax_num
        
        
        //追加itemがinvenotryにあるときは更新、ないときはsaveinvnetory functionで追加
        
        if  realm.object(ofType: Inventory.self, forPrimaryKey: newInventory.item) != nil {
            let inventoryrow = realm.objects(Inventory.self).filter("item = '\(item)'")
            try! realm.write {
                print("はいれた!")
                for element in inventoryrow {
                    let exnum = element.quantity
                    print(exnum)
                    let nownum = newInventory.quantity
                    print(nownum)
                    element.quantity = exnum + nownum
                    print(element.quantity)
                }
            }
        } else {
            self.saveInventoryData(model: newInventory, realm: realm)
            //self.savePurchasedData(model: newpurchased, realm: realm)
        
    }
  }
    

}
