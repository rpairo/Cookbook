//
//  FetchIngredientsUseCaseable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

//MARK: Use case errors
enum FetchIngredientsError: Error {
    case url
    case decoding
    case emptyList
    case unkown(Error)
}

//MARK: Use case result
typealias FetchIngredientsResult = (Result<[Ingredient], FetchIngredientsError>) -> Void

protocol FetchIngredientsUseCaseable {
    // MARK: Functionality
    func execute(onComplete: @escaping FetchIngredientsResult)
}
