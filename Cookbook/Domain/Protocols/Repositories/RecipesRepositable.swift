//
//  RecipesRepositable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

protocol RecipesRepositable {
    // MARK: Fcuntionality
    func fetch(onComplete: @escaping FetchRecipesResult)
}
