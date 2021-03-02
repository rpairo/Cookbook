//
//  ImagesRepository.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct ImagesRepository: ImagesRepositable {
    // MARK: Data sources
    var imagesDataSource: ImagesDataSourceable

    // MARK: Functionality
    func fetch(name: String, onComplete: @escaping FetchImageResult) {
        imagesDataSource.fetch(name: name, onComplete: onComplete)
    }
}
