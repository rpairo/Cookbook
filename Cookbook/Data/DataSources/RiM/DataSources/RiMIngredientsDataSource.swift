//
//  RiMIngredientsDataSource.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

class RiMIngredientsDataSource: IngredientsDataSourceable {
    // MARK: Properties
    var configuration: RiMConfiguration? {
        let file = "RiM"
        let type = "plist"

        guard let path = Bundle.main.url(forResource: file, withExtension: type) else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }

        let decoder = PropertyListDecoder()
        guard let config = try? decoder.decode(RiMConfiguration.self, from: data) else { return nil }
        return config
    }
}
