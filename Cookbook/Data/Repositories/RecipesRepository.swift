//
//  RecipesRepository.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct RecipesRepository: RecipesRepositable {
    // MARK: Data sources
    var recipesDataSource: RecipesDataSourceable

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchRecipesResult) {
        recipesDataSource.fetch(onComplete: onComplete)
    }
}
