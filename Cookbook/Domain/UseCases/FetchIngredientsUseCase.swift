//
//  FetchIngredientsUseCase.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

struct FetchIngredientsUseCase: FetchIngredientsUseCaseable {
    // MARK: Repositories
    var ingredientsRepository: IngredientsRepositable

    // MARK: Functionality
    func execute(onComplete: @escaping FetchIngredientsResult) {
        ingredientsRepository.fetch(onComplete: onComplete)
    }
}
