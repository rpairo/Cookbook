//
//  FetchImageUseCase.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct FetchImageUseCase: FetchImageUseCaseable {
    // MARK: Repositories
    var imagesRepository: ImagesRepositable

    // MARK: Functionality
    func execute(name: String, onComplete: @escaping FetchImageResult) {
        imagesRepository.fetch(name: name, onComplete: onComplete)
    }
}
