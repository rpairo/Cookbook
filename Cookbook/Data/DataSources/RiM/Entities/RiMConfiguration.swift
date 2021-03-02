//
//  RiMConfiguration.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import Foundation

enum Endpoints: String {
    case ingredients = "Ingredients"
}

struct RiMConfiguration: Decodable {
    // MARK: Properties
    private var endpoints: [String: String]

    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case endpoints = "Endpoints"
    }

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        endpoints = try container.decode([String: String].self, forKey: .endpoints)
    }

    // MARK: Functionality
    func endpoint(_ endpoint: Endpoints) -> String? {
        self.endpoints[endpoint.rawValue]
    }
}
