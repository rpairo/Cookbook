//
//  FilterRecipesByIngredientsUseCaseable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 4/3/21.
//

import Foundation

protocol FilterRecipesByIngredientsUseCaseable {
    // MARK: Functionality
    func execute(recipes: [Recipe], ingredients: [Ingredient]) -> [Recipe]
}
