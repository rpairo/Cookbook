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

    // MARK: Use cases
    var fetchIngredientsUseCase: FetchIngredientsUseCaseable

    // MARK: Constructor
    init(fetchIngredientsUseCase: FetchIngredientsUseCaseable) {
        self.fetchIngredientsUseCase = fetchIngredientsUseCase
    }

    // MARK: Lifecycle
    func onAppear() {
        fetchIngredients()
    }

    func fetchIngredients() {
        fetchIngredientsUseCase.execute { result in
            switch result {
            case .success(let ingredients):
                DispatchQueue.main.async {
                    self.ingredients = ingredients
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
