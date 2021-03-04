//
//  ImageDTO.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation


struct ImageDTO: Decodable {
    // MARK: Properties
    var medium: String
    var large: String

    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case medium = "webformatURL"
        case large = "largeImageURL"
    }

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        medium = try container.decode(String.self, forKey: .medium)
        large = try container.decode(String.self, forKey: .large)
    }
}
