//
//  PixabayImagesDataSource.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

class PixabayImagesDataSource: ImagesDataSourceable {
    // MARK: Properties
    var configuration: PixabayConfiguration? {
        let file = "Pixabay"
        let type = "plist"

        guard let path = Bundle.main.url(forResource: file, withExtension: type) else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }

        let decoder = PropertyListDecoder()
        guard let config = try? decoder.decode(PixabayConfiguration.self, from: data) else { return nil }
        return config
    }
}
