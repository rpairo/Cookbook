//
//  RiMRecipesDataSource+Fetch.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

extension RiMRecipesDataSource {
    // MARK: Properties
    var fetchUrl: URL? {
        guard let endpoint = configuration?.endpoint(.recipes) else { return nil }
        guard let url = URL(string: endpoint) else { return nil }
        return url
    }

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchRecipesResult) {
        let session = URLSession(configuration: .default)
        guard let url = fetchUrl else {
            onComplete(.failure(.url))
            return
        }

        session.dataTask(with: url) { data, result, error in
            if let error = error {
                onComplete(.failure(.unkown(error)))
            }

            guard let recipes = self.decodeRecipes(data) else {
                onComplete(.failure(.decoding))
                return
            }

            guard !recipes.recipes.isEmpty else {
                onComplete(.failure(.emptyList))
                return
            }

            onComplete(.success(recipes.transform()))
        }
        .resume()
    }
}

// MARK: Transformations
extension RiMRecipesDataSource {
    func decodeRecipes(_ data: Data?) -> RecipesDTO? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        guard let recipes = try? decoder.decode(RecipesDTO.self, from: data) else { return nil }
        return recipes
    }
}
