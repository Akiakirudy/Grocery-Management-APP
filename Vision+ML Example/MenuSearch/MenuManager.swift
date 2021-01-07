//
//  MenuManager.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/8/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreLocation

protocol MenuManagerDelegate {
    func didUpdateMenu(_ MenuManager: MenuManager, repilist: [MenuModel])
    func didFailWithError(error: Error)
}


struct MenuManager {
    var delegate: MenuManagerDelegate?
    func menuSearch(ingridients: String) {
        let urlString = "APIURL"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let menu = self.parseJSON(safeData) {
                        //print(menu)
                        self.delegate?.didUpdateMenu(self, repilist: menu)//他のfile で定義したdidupdateの式をdelegateで任せる
                    }
                }
            }
            task.resume()
        }
    }

    
    func parseJSON(_ Recipe: Data) -> [MenuModel]? {
        let decoder = JSONDecoder()
        var repilist : [MenuModel] = []
        do {
            let decodedData = try! decoder.decode(Root.self, from: Recipe)
            let number = decodedData.hits.count
            let numberr = number - 1
            for indexx in 0...numberr {
                let recipe_name = decodedData.hits[indexx].recipe.name
                let img = decodedData.hits[indexx].recipe.image
                let ing_list =  decodedData.hits[indexx].recipe.ingredientList
                //detailurl = decodedData.hits[0].recipe.seeMoreUrl
                let menu = MenuModel(recipename: recipe_name, image: img, inglist: ing_list)
                repilist.append(menu)
            }
             //print(repilist)
             return repilist
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

