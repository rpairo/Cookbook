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

    // MARK: Constructor
    init(fetchIngredientsUseCase: FetchIngredientsUseCaseable,
         fetchRecipesUseCase: FetchRecipesUseCaseable) {

        self.fetchIngredientsUseCase = fetchIngredientsUseCase
        self.fetchRecipesUseCase = fetchRecipesUseCase
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
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
