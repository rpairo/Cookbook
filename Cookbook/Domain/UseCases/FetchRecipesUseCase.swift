//
//  FetchRecipesUseCase.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct FetchRecipesUseCase: FetchRecipesUseCaseable {
    // MARK: Repositories
    var recipesRepository: RecipesRepositable

    // MARK: Functionality
    func execute(onComplete: @escaping FetchRecipesResult) {
        recipesRepository.fetch(onComplete: onComplete)
    }
}
