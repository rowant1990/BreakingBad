//
//  Character.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

struct Character: Decodable, Equatable {
    
    let id: Int
    let name: String
    let imagePath: String
    let status: String
    let nickname: String
    let occupations: [String]
    let appearance: [Int]

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case imagePath = "img"
        case occupations = "occupation"
        case name, status, nickname, appearance
    }
}
