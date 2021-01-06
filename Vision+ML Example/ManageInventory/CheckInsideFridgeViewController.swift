
import UIKit
import RealmSwift

class CheckInsideFridgeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var table : UITableView!
    @IBOutlet var field : UITextField!
    

    var results = [String]()
    var item_column = [String]()
    var quanti_column = [Int]()
    var filteredData = [String]()
    var filtered = false// 検索したものが冷蔵庫にあるかないかを示すもの
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    
    
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
            item_column.append(row.item)//results = [[item, 3, date], [item, 4, date]]になってるので、itemをrow(results[0])からとりだす

        }
        for row in results {
            quanti_column.append(row.quantity)
        
        }
        print(item_column)
        print(quanti_column)
    
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filterText(text+string)
        }
        return true
    }
    
    func filterText(_ query: String) {
        filteredData.removeAll()//検索のはこの中をからにする。
        for string in item_column {
            if string.starts(with: query) {// 検索したstringがitem_columnのstring にあるとしたら、filteredDataにそのstring をitem_columnのstring をいれる。
                print(string)
                filteredData.append(string)
            }
        }
        table.reloadData()//tableViewをもういちど
        filtered = true
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        print(String(item_column.count))
        return filtered ? 0 : item_column.count //検索したfilteredDataがitem_columnにないときは、なにも表示しないように0をいれる
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Memo.cellIdentifierFri, for: indexPath)//identifier をstoryboard のtable cellでidentify する。ちなみにmemoのcellIdentifierFriと名前を一致させる。
        if !filteredData.isEmpty {
            print(filteredData[indexPath.row])
            cell.textLabel?.text = filteredData[indexPath.row]//検索箱の中がemptyではないとき検索の中()
        } else {
            cell.textLabel?.text = item_column[indexPath.row]
            cell.detailTextLabel?.text = String(quanti_column[indexPath.row])
            print("you are creating")
          
        }
        return cell
    }

}
//https://www.youtube.com/watch?v=-UQcifmThag
//search Fieldつける
//食材のcategorize をUITableViewのSeparator Styleで区切る。
