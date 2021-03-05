//
//  Ingredient.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

struct Ingredient: Identifiable {
    // MARK: Properties
    var id: UUID
    var name: String
    var image: Data?
}


extension Ingredient: Equatable {
    // MARK: Functionality
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name == rhs.name
    }
}
