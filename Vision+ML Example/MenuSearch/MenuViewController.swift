//
//  MenuViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/7/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var seachTextField : UITextField!
    @IBOutlet weak var onelabel : UILabel!
    @IBOutlet weak var twolabel : UILabel!
    @IBOutlet weak var threelabel : UILabel!
    @IBOutlet weak var firstlabel : UILabel!
    @IBOutlet weak var secondlabel : UILabel!
    @IBOutlet weak var thirdlabel : UILabel!
    @IBOutlet weak var oneImageView : UIImageView!
    @IBOutlet weak var twoImageView : UIImageView!
    @IBOutlet weak var threeImageView : UIImageView!
    @IBOutlet weak var tableView : UITableView!
    
    var menuManager = MenuManager()
    var selectedIndex : IndexPath = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CustomCell", bundle: nil),forCellReuseIdentifier:"Recipecell")
        menuManager.delegate = self
        seachTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 350
    }
    
    //donetypign dismiss keyboard
    @IBAction func searchPressed(_ sender: UIButton) {
        seachTextField.endEditing(true)//donetypign dismiss keyboard
        print(seachTextField.text!)
        tableView.reloadData()//押した時にtableviewがsearchfieldに合わせて変化されるように
        }
    
    //click go and search
    func textFieldShouldReturn(_ textFiled: UITextField) -> Bool {
        seachTextField.endEditing(true)
        print(seachTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type some food you want to eat today"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //get recommendation for the food , search in google or dictionary
        if let ingridient = seachTextField.text {
            menuManager.menuSearch(ingridients: ingridient)
        }
        seachTextField.text = ""
    }
}


extension MenuViewController: MenuManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let images = [oneImageView.image, twoImageView.image, threeImageView.image]
        let titles = [onelabel.text, twolabel.text, threelabel.text]
        let ingridients = [firstlabel.text, secondlabel.text, thirdlabel.text]
        let cell : CustomCell = tableView.dequeueReusableCell(withIdentifier: "Recipecell", for: indexPath) as! CustomCell
        cell.setUp(recipetitle: titles[indexPath.row] , image: images[indexPath.row], ingrilist: ingridients[indexPath.row])
       
        //customcellのimageviewなどに繋げるためにsetupをcustomcellに作っておいて、値を挿入
        return cell
        
    }
    
    //swipe動作と次のviewに繋ぐ
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let action = UITableViewRowAction(style: .normal, title: "See more details →"){ action, indexPath in
                self.performSegue(withIdentifier: "showdetail", sender: self)
                //ここに次のview入れる。
                
            }
            
        selectedIndex = indexPath
        print(indexPath)
        action.backgroundColor = #colorLiteral(red: 0.9047068357, green: 0.7893832326, blue: 0.6492891908, alpha: 1)
        return [action]
    }
    
    //次のviewに値を渡す。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let images = [oneImageView.image, twoImageView.image, threeImageView.image]
        let titles = [onelabel.text!, twolabel.text!, threelabel.text!]
        let ingridients = [firstlabel.text!, secondlabel.text!, thirdlabel.text!]
        let destination = segue.destination as! DetailVCF

        //下のやり方だど三つ目のcellの画像とlabelが全部のcellのnext viewに肺いてしまう
        print(selectedIndex)
        destination.recipeimage = images[selectedIndex[1]]
        destination.recipename = titles[selectedIndex[1]]
        destination.list = ingridients[selectedIndex[1]]
    
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateMenu(_ MenuManager: MenuManager, repilist: [MenuModel]) {
        DispatchQueue.main.async {
            
            let listone = repilist[0].inglist
            let firstlist = listone.joined(separator: ", ")
            let listwo = repilist[1].inglist
            let secondlist = listwo.joined(separator: ", ")
            let listhree = repilist[2].inglist
            let thirdlist = listhree.joined(separator: ", ")
            self.onelabel.text = repilist[0].recipename
            let oneurl = repilist[0].image
            self.firstlabel.text = firstlist
            self.twolabel.text = repilist[1].recipename
            let twourl = repilist[1].image
            self.secondlabel.text = secondlist
            self.threelabel.text  = repilist[2].recipename
            let threeurl = repilist[2].image
            self.thirdlabel.text = thirdlist
            
            if let data = try? Data(contentsOf: oneurl) {
                self.oneImageView.image = UIImage(data: data)
            }
            if let data = try? Data(contentsOf: twourl) {
                self.twoImageView.image = UIImage(data: data)
            }
            if let data = try? Data(contentsOf: threeurl) {
                self.threeImageView.image = UIImage(data: data)
            }
//            let num = repilist.count
//            let nummi = num - 1
//            for i in 0...nummi {
//                self.menulabel.text = repilist[i].recipename
//            //self.ingridientslabel.text = menu.inglist[0]
//                let url = repilist[i].image
//                if let data = try? Data(contentsOf: url) {
//                    self.menuImageView.image = UIImage(data: data)
//                }
            }
        }
    }

//menu こんな感じにする
//https://developer.apple.com/tutorials/swiftui/handling-user-input
//写真がそのままupかくだいされるanimation つくる

