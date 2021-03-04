//
//  FetchRecipesUseCaseable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

//MARK: Use case errors
enum FetchRecipesError: Error {
    case url
    case decoding
    case emptyList
    case unkown(Error)
}

//MARK: Use case result
typealias FetchRecipesResult = (Result<[Recipe], FetchRecipesError>) -> Void

protocol FetchRecipesUseCaseable {
    // MARK: Functionality
    func execute(onComplete: @escaping FetchRecipesResult)
}
