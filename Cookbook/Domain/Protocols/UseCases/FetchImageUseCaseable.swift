//
//  FetchImageUseCaseable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

//MARK: Use case errors
enum FetchImageError: Error {
    case url
    case decoding
    case empty
    case unkown(Error)
}

//MARK: Use case result
typealias FetchImageResult = (Result<String, FetchImageError>) -> Void

protocol FetchImageUseCaseable {
    // MARK: Functionality
    func execute(name: String, onComplete: @escaping FetchImageResult)
}
