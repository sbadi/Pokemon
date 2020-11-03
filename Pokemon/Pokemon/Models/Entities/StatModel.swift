//
//  StatModel.swift
//  Pokemon
//
//  Created by Alberto Bo on 29/10/2020.
//

import Foundation

struct StatsModel: ModelType {

    var stat: StatModel?
    var base: Int?
    var effort: Int?

    enum CodingKeys: String, CodingKey {
        case stat = "stat"
        case effort = "effort"
        case base = "base_stat"
    }
}

struct StatModel: ModelType {

    var name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}
