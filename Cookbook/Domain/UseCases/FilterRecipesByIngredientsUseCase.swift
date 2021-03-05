//
//  FilterRecipesByIngredientsUseCase.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 4/3/21.
//

import Foundation

struct FilterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable {
    // MARK: Functionality
    func execute(recipes: [Recipe], ingredients: [Ingredient]) -> [Recipe] {
        recipes.filter { recipe in
            ingredients.contains(array: recipe.ingredients)
        }
    }
}

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) {
                return false
            }
        }

        return true
    }
}
