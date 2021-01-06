import UIKit
import RealmSwift

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table : UITableView!

    

    var results = [String]()
    var item_column = [String]()
    var quanti_column = [Int]()
    var zero_Item = [String]()
    var zero_Quantity = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    
    
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
        
        let realm = try! Realm()
       
        //realm のinventory Entityから(item: , quantity: , date: )を受け継ぐ
        let results = realm.objects(Inventory.self)
        
        for row in results {
            if row.quantity == 0 {
                zero_Item.append(row.item)
                zero_Quantity.append(row.quantity)
            }
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return zero_Item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Memo.cellIdentifierShop, for: indexPath)//identifier
        cell.textLabel?.text = zero_Item[indexPath.row]
        cell.detailTextLabel?.text = String(zero_Quantity[indexPath.row])
        return cell
    }
//https://www.youtube.com/watch?v=-UQcifmThag
//search Fieldつける
//食材のcategorize をUITableViewのSeparator Styleで区切る。

}
