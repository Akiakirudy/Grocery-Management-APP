//
//  MenuData.swift
//  Vision+ML Example
//
//  Created by Akira Tachibana on 12/8/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation

struct Root: Codable {
    let hits : [Hit]
}


struct Hit: Codable {
    let recipe: Recipes
}

struct Recipes: Codable {
    let name: String
    let image: URL
    let ingredientList: [String]
    let seeMoreUrl: URL

    enum CodingKeys: String, CodingKey {
        case name = "label"
        case image
        case ingredientList = "ingredientLines"
        case seeMoreUrl = "url"
    }
}

