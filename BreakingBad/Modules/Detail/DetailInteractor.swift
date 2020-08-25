//
//  DetailInteractor.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class DetailInteractor {
    
    let character: Character
    weak var output: DetailInteractorOutput?

    init(character: Character) {
        self.character = character
    }
}

extension DetailInteractor: DetailInteractorInput {
    func loadCharacter() {
        output?.loadImage(character.imagePath)
    }
    
    func loadRows() -> [DetailRow] {
         return CharacterDetailAttribute.allCases.map { DetailRow(title: $0.rawValue.capitalized, content: $0.content(for: character))  }
    }
}

enum CharacterDetailAttribute: String, CaseIterable {
    case name, occupation, status, nickname, appearance
}

extension CharacterDetailAttribute {
    func content(for character: Character) -> String {
        switch self {
        case .name: return character.name
        case .occupation: return character.occupations.joined(separator: ", ")
        case .nickname: return character.nickname
        case .status: return character.status
        case .appearance: return character.appearance.map({ String($0) }).joined(separator: ", ")
        }
    }
}
