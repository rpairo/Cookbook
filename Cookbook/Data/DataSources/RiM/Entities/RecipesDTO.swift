//
//  RecipesDTO.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct RecipesDTO: Decodable {
    // MARK: Properties
    var recipes: [RecipeDTO]

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        recipes = try container.decode([RecipeDTO].self)
    }

    // MARK: Functionality
    func transform() -> [Recipe] {
        recipes.map { recipe in
            recipe.transform()
        }
    }
}
