//
//  PixabayConfiguration.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct PixabayConfiguration: Decodable {
    // MARK: Properties
    var endpoint: String
    var key: String

    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case endpoint = "Endpoint"
        case key = "Key"
    }

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        endpoint = try container.decode(String.self, forKey: .endpoint)
        key = try container.decode(String.self, forKey: .key)
    }
}
