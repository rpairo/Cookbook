//
//  DiscoverViewModel+Fetch.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 5/3/21.
//

import Foundation

// MARK: Fetching data
extension DiscoverViewModel {
    // MARK: Functionality
    func fetchIngredients(onComplete: @escaping () -> Void) {
        fetchIngredientsUseCase.execute { result in
            switch result {
            case .success(let ingredients):
                DispatchQueue.main.async {
                    self.ingredients = ingredients
                    onComplete()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func fetchRecipes(onComplete: @escaping () -> Void) {
        fetchRecipesUseCase.execute { result in
            switch result {
            case .success(let recipes):
                let filtered = self.filterRecipesByIngredientsUseCase.execute(
                    recipes: recipes,
                    ingredients: self.ingredients
                )

                DispatchQueue.main.async {
                    self.recipes = filtered
                    onComplete()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: Images loading
extension DiscoverViewModel {
    func fetchIngredientsImages() {
        for (index, ingredient) in ingredients.enumerated() {
            fetchImageUseCase.execute(name: ingredient.name) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.ingredients[index].image = image
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

    func fetchRecipesImages() {
        for (index, recipe) in recipes.enumerated() {
            fetchImageUseCase.execute(name: recipe.name) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.recipes[index].image = image
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
