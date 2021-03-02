//
//  IngredientsRepositable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

protocol IngredientsRepositable {
    // MARK: Fcuntionality
    func fetch(onComplete: @escaping FetchIngredientsResult)
}
