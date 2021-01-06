//
//  CustomCellViewController.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var menuImage : UIImageView!
    @IBOutlet weak var recipelabel : UILabel!
    @IBOutlet weak var ingridientslabel : UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
        
    }
    
    func setUp(recipetitle: String?, image: UIImage?, ingrilist: String?) {
        menuImage.layer.masksToBounds = false //UIImageを円にする
        menuImage.layer.cornerRadius = menuImage.frame.height/2
        menuImage.clipsToBounds = true
        
        recipelabel.text = recipetitle
        menuImage.image = image //UIImageはmenuImage.image 。でも先ほどimageをUIImageViewに変換し、UIImageの形を丸にかえたので.image入れずにそのまま挿入
        ingridientslabel.text = ingrilist
        
    }
}
