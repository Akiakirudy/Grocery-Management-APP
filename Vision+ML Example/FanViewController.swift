//
//  FanViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//


import UIKit
import FanMenu
import Macaw

class FanViewController: UIViewController {

    @IBOutlet weak var fanMenu: FanMenu!
    
    let items = [
        ("dollar", 0xcdb071),
        ("scan", 0xd7806d),
        ("search", 0xd6dda8),
        ("cart", 0xe7cb95),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "home"),
            color: Color(val: 0x644430)
        )
        
        fanMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: button.0),
                color: Color(val: button.1)
            )
        }
        
        fanMenu.menuRadius = 150.0
        fanMenu.duration = 0.2
        fanMenu.delay = 0.05
        fanMenu.interval = (Double.pi, 2 * Double.pi)

        fanMenu.onItemDidClick = { button in
            print("ItemDidClick: \(button.id)")
           
        }

        fanMenu.onItemWillClick = { button in
            print("ItemWillClick: \(button.id)")
            if button.id == "dollar" {
                self.performSegue(withIdentifier: "toExpenseVC", sender: nil)
            }
            if button.id == "scan" {
                self.performSegue(withIdentifier: "toImageVC", sender: nil)
            }
            if button.id == "search" {
                self.performSegue(withIdentifier: "toMenuVC", sender: nil)
            }
            if button.id == "cart" {
                self.performSegue(withIdentifier: "toShoplistVC", sender: nil)
            }
            
        }
        
        fanMenu.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           fanMenu.updateNode()
       }
    

}
