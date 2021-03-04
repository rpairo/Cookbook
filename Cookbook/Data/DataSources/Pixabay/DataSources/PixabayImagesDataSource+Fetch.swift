//
//  PixabayImagesDataSource+Fetch.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

extension PixabayImagesDataSource {
    // MARK: Properties
    var fetchEndpoint: String? {
        guard let endpoint = configuration?.endpoint else { return nil }
        return endpoint
    }

    var apiKey: String? {
        guard let apiKey = configuration?.key else { return nil }
        return apiKey
    }

    // MARK: Functionality
    func fetch(name: String, onComplete: @escaping FetchImageResult) {
        let session = URLSession(configuration: .default)

        guard let url = urlBuilder(image: name) else {
            onComplete(.failure(.url))
            return
        }

        session.dataTask(with: url) { data, result, error in
            if let error = error {
                onComplete(.failure(.unkown(error)))
            }

            guard let images = self.decodeImages(data) else {
                onComplete(.failure(.decoding))
                return
            }

            guard let image = images.images.first else {
                onComplete(.failure(.empty))
                return
            }

            guard let url = URL(string: image.medium) else {
                onComplete(.failure(.decoding))
                return
            }

            guard let data = try? Data(contentsOf: url) else {
                onComplete(.failure(.decoding))
                return
            }

            onComplete(.success(data))
        }
        .resume()
    }
}

// MARK: Transformations
extension PixabayImagesDataSource {
    func urlBuilder(image name: String) -> URL? {
        guard let endpoint = fetchEndpoint else { return nil }
        guard let apiKey = apiKey else { return nil }

        let parameters = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: name),
            URLQueryItem(name: "image_type", value: "photo"),
            URLQueryItem(name: "category", value: "food")
        ]

        var urlComponents = URLComponents(string: endpoint)
        urlComponents?.queryItems = parameters

        guard let url = urlComponents?.url else { return nil }
        return url
    }

    func decodeImages(_ data: Data?) -> ImagesDTO? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        guard let recipes = try? decoder.decode(ImagesDTO.self, from: data) else { return nil }
        return recipes
    }
}
