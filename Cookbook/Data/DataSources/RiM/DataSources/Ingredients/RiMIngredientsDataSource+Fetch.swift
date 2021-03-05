//
//  RiMIngredientsDataSource+Fetch.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

extension RiMIngredientsDataSource {
    // MARK: Properties
    var fetchUrl: URL? {
        guard let endpoint = configuration?.endpoint(.ingredients) else { return nil }
        guard let url = URL(string: endpoint) else { return nil }
        return url
    }

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchIngredientsResult) {
        let session = URLSession(configuration: .default)
        guard let url = fetchUrl else {
            onComplete(.failure(.url))
            return
        }

        session.dataTask(with: url) { data, result, error in
            if let error = error {
                onComplete(.failure(.unkown(error)))
            }

            guard let ingredients = self.decodeIngredients(data) else {
                onComplete(.failure(.decoding))
                return
            }

            guard !ingredients.ingredients.isEmpty else {
                onComplete(.failure(.emptyList))
                return
            }

            onComplete(.success(ingredients.transform()))
        }
        .resume()
    }
}

// MARK: Transformations
extension RiMIngredientsDataSource {
    func decodeIngredients(_ data: Data?) -> IngredientsDTO? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        guard let ingredients = try? decoder.decode(IngredientsDTO.self, from: data) else { return nil }
        return ingredients
    }
}
