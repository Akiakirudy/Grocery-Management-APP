//
//  DetailVC.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/20/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DetailVCF: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(listingri.count)
        return listingri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridients", for: indexPath)
        cell.textLabel?.text = listingri[indexPath.row]
        cell.imageView?.image = UIImage(named: "checkrec")
        print(listingri[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
            if let cell = tableView.cellForRow(at: indexPath) {
                 
                // 画像を切り替えと Dictonary の値を変更
                if cell.imageView?.image == UIImage(named: "check") {
                    cell.imageView?.image = UIImage(named: "checkrec")
                } else {
                    cell.imageView?.image = UIImage(named: "check")
                }
                // 選択状態を解除
                cell.isSelected = false
            }
        }
    
    var recipename = ""
    var recipeimage : UIImage!
    var list = ""
    var listingri = [""]
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var label : UILabel!
    @IBOutlet weak var ingriTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingriTableView.delegate = self
        ingriTableView.dataSource = self
        label.text = recipename
        image.image = recipeimage
        listingri  = list.components(separatedBy: ",")
        // Do any additional setup after loading the view.
        
       
    }


}
