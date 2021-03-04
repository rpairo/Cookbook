//
//  RecipesViewModel.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

class RecipesViewModel: ObservableObject {
    // MARK: Properties
    @Published var ingredients = [Ingredient]()
    @Published var recipes = [Recipe]()

    // MARK: Use cases
    var fetchIngredientsUseCase: FetchIngredientsUseCaseable
    var fetchRecipesUseCase: FetchRecipesUseCaseable
    var fetchImageUseCase: FetchImageUseCase

    // MARK: Constructor
    init(fetchIngredientsUseCase: FetchIngredientsUseCaseable,
         fetchRecipesUseCase: FetchRecipesUseCaseable,
         fetchImageUseCase: FetchImageUseCase) {

        self.fetchIngredientsUseCase = fetchIngredientsUseCase
        self.fetchRecipesUseCase = fetchRecipesUseCase
        self.fetchImageUseCase = fetchImageUseCase
    }

    // MARK: Lifecycle
    func onAppear() {
        fetchIngredients()
        fetchRecipes()
    }

    // MARK: Functionality
    func fetchIngredients() {
        fetchIngredientsUseCase.execute { result in
            switch result {
            case .success(let ingredients):
                DispatchQueue.main.async {
                    self.ingredients = ingredients
                    self.fetchIngredientsImages()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func fetchRecipes() {
        fetchRecipesUseCase.execute { result in
            switch result {
            case .success(let recipes):
                DispatchQueue.main.async {
                    self.recipes = recipes
                    self.fetchRecipesImages()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

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
