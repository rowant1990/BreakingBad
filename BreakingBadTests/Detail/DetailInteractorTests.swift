//
//  DetailInteractor.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import XCTest
@testable import BreakingBad

class DetailInteractorTests: XCTestCase {
    
    func testShouldLoadRows() {
        let character = Character(id: 1, name: "Rowan", imagePath: "image", status: "status", nickname: "nickname", occupations: ["mobile", "web"], appearance: [2,3,4])
        let sut = DetailInteractor(character: character)
        let rows = sut.loadRows()
        rows.forEach { row in
            if CharacterDetailAttribute(rawValue: row.title.lowercased()) == .occupation {
                XCTAssertEqual(row.content, "mobile, web")
            } else if CharacterDetailAttribute(rawValue: row.title.lowercased()) == .appearance {
                XCTAssertEqual(row.content, "2, 3, 4")
            }
        }
        XCTAssertEqual(rows.count, 5)
    }
}
