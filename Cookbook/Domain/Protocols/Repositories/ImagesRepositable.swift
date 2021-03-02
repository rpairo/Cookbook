//
//  ImagesRepositable.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

protocol ImagesRepositable {
    // MARK: Fcuntionality
    func fetch(name: String, onComplete: @escaping FetchImageResult)
}
