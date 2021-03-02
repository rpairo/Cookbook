//
//  IngredientsRepository.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

struct IngredientsRepository: IngredientsRepositable {
    // MARK: Data source
    var ingredientsDataSource: IngredientsDataSourceable

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchIngredientsResult) {
        ingredientsDataSource.fetch(onComplete: onComplete)
    }
}
