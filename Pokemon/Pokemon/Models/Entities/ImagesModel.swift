//
//  ImagesModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import Foundation


struct ImageModel: ModelType {

    var imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case imageUrl = "front_default"
    }
}

struct OtherModel: ModelType {

    var icon: ImageModel?
    var officialArtwork: ImageModel?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case icon = "dream_world"
    }
}

struct ImagesModel: ModelType {

    var other: OtherModel?

    var officialArtwork: String? { other?.officialArtwork?.imageUrl }
    var icon: String? { other?.icon?.imageUrl }

    enum CodingKeys: String, CodingKey {
        case other = "other"
    }
}
