//
//  ImagesDTO.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 2/3/21.
//

import Foundation

struct ImagesDTO: Decodable {
    // MARK: Properties
    var images: [ImageDTO]

    // MARK: Keys
    enum CodingKeys: String, CodingKey {
        case images = "hits"
    }

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        images = try container.decode([ImageDTO].self, forKey: .images)
    }
}
