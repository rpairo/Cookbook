//
//  ImagesDataSourceable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

protocol ImagesDataSourceable {
    // MARK: Functionality
    func fetch(name: String, onComplete: @escaping FetchImageResult)
}
