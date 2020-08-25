//
//  ListInteractorTests.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import XCTest
@testable import BreakingBad

class ListInteractorTests: XCTestCase {
    
    var sut: ListInteractor!
    var mockSession: MockURLSession!
    var mockOutput: MockListInteractorOutput!
    
    override func setUp() {
        super.setUp()
        mockOutput = MockListInteractorOutput()
        mockSession = MockURLSession()
        sut = ListInteractor(networkClient: NetworkClient(session: mockSession), queue: SameThreadExecuter())
        sut.output = mockOutput
    }
    
    override func tearDown() {
        mockOutput = nil
        mockSession = nil
        sut = nil
        super.tearDown()
    }
    
    func testShouldReturnFoundCharacters() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        XCTAssertEqual(mockOutput.characters?.first?.id, 1)
        XCTAssertEqual(mockOutput.characters?.first?.name, "Rowan")
    }
    
    func testShouldReturnSendErrorToOutput() {
        mockSession.error = NetworkClientError.noData
        sut.fetchCharacter()
        XCTAssert(mockOutput.isError)
    }
    
    func testShouldMatchCharactersOnSearch() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 3, "name": "Steven", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.search("Rowan")
        XCTAssertEqual(mockOutput.characters?.first?.name, "Rowan")
        XCTAssertEqual(mockOutput.characters?.count, 1)
    }
    
    func testShouldPartialMatchCharactersOnSearch() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 3, "name": "Steven", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.search("Stev")
        XCTAssertEqual(mockOutput.characters?.first?.name, "Steve")
        XCTAssertEqual(mockOutput.characters?.count, 2)
    }
    
    func testShouldReturnEmptyWithNoCharacterMatch() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 3, "name": "Steven", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.search("Hannah")
        XCTAssertEqual(mockOutput.characters?.count, 0)
    }
    
    func testShouldResetCharactersBack() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.search("Steve")
        sut.reset()
        XCTAssertEqual(mockOutput.characters?.count, 2)
    }
  
    func testShouldFilterCharactersOnAppearance() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [2,3,4] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [1,2,5] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.filter([1,5])
        XCTAssertEqual(mockOutput.characters?.first?.id, 2)
        XCTAssertEqual(mockOutput.characters?.count, 1)
    }
    
    func testShouldFilterCharactersOnMultipleAppearance() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [2,3,4] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [1,2] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.filter([2])
        XCTAssertEqual(mockOutput.characters?.count, 2)
    }
    
    func testShouldReturnEmpyWhenNoCharactersAppear() {
        let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [2,3,4] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [1,2] ]]
        mockSession.body = characters
        sut.fetchCharacter()
        sut.filter([1,2,3,4,5])
        XCTAssertEqual(mockOutput.characters?.count, 0)
    }
    
    func testShouldResetCharactersBackIncludingFilter() {
          let characters = [[ "char_id": 1, "name": "Rowan", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [1,2,3] ], [ "char_id": 2, "name": "Steve", "img": "t", "status": "t", "nickname": "t", "occupation": [], "appearance": [1,2,3,4] ]]
          mockSession.body = characters
          sut.fetchCharacter()
          sut.filter([1,2,3,4])
          sut.search("Rowan")
          sut.reset()
          XCTAssertEqual(mockOutput.characters?.count, 1)
      }
}

class MockListInteractorOutput: ListInteractorOutput {
    
    var characters: [Character]?
    var isError = false
    
    func charactersFound(_ characters: [Character]) {
        self.characters = characters
    }
    
    func errorReturned(_ error: Error) {
        isError = true
    }
}
