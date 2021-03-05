//
//  RecipesDataSourceable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

protocol RecipesDataSourceable {
    // MARK: Functionality
    func fetch(onComplete: @escaping FetchRecipesResult)
}
