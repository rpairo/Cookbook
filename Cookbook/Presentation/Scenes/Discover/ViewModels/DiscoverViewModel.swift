//
//  RecipesViewModel.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

class DiscoverViewModel: ObservableObject {
    // MARK: Properties
    @Published var ingredients = [Ingredient]()
    @Published var recipes = [Recipe]()

    // MARK: Use cases
    var fetchIngredientsUseCase: FetchIngredientsUseCaseable
    var fetchRecipesUseCase: FetchRecipesUseCaseable
    var fetchImageUseCase: FetchImageUseCaseable
    var filterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable

    // MARK: Constructor
    init(fetchIngredientsUseCase: FetchIngredientsUseCaseable,
         fetchRecipesUseCase: FetchRecipesUseCaseable,
         fetchImageUseCase: FetchImageUseCase,
         filterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable) {

        self.fetchIngredientsUseCase = fetchIngredientsUseCase
        self.fetchRecipesUseCase = fetchRecipesUseCase
        self.fetchImageUseCase = fetchImageUseCase
        self.filterRecipesByIngredientsUseCase = filterRecipesByIngredientsUseCase
    }

    // MARK: Lifecycle
    func onAppear() {
        self.fetchIngredients {
            self.fetchIngredientsImages()

            self.fetchRecipes {
                self.fetchRecipesImages()
            }
        }
    }
}

// MARK: Events
extension DiscoverViewModel {
    func settingsTapped() {
        print("Config button tapped")
    }
}
