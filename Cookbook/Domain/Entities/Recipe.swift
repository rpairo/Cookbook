//
//  Recipe.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct Recipe: Identifiable {
    // MARK: Properties
    var id: UUID
    var name: String
    var image: Data?
    var ingredients: [Ingredient]
}
