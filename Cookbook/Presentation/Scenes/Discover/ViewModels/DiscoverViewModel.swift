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
