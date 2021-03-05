//
//  IngredientsDataSourceable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

protocol IngredientsDataSourceable {
    // MARK: Functionality
    func fetch(onComplete: @escaping FetchIngredientsResult)
}
