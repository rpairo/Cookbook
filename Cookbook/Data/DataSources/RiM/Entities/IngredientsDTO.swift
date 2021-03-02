//
//  Ingredient.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

struct IngredientsDTO: Decodable {
    // MARK: Properties
    var ingredients: [String]

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        ingredients = try container.decode([String].self)
    }

    // MARK: Functionality
    func transform() -> [Ingredient] {
        ingredients.map { ingredient in
            Ingredient(id: UUID(), name: ingredient)
        }
    }
}
