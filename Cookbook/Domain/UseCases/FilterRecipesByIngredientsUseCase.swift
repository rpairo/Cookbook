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
            thereIs(this: recipe.ingredients, in: ingredients)
        }
    }

    func thereIs(this recipe: [Ingredient], in ingredients: [Ingredient]) -> Bool {
        for ingredient in recipe {
            guard ingredients.contains(where: { $0.name == ingredient.name }) else {
                return false
            }
        }

        return true
    }
}
