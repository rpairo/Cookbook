//
//  RecipeDTO.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct RecipeDTO: Decodable {
    // MARK: Properties
    var name: String
    var ingredients: IngredientsDTO

    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case name
        case ingredients
    }

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        ingredients = try container.decode(IngredientsDTO.self, forKey: .ingredients)
    }

    // MARK: Functionality
    func transform() -> Recipe {
        Recipe(
            id: UUID(),
            name: name,
            ingredients: ingredients.transform()
        )
    }
}
