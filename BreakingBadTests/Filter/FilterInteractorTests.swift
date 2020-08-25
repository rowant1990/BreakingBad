//
//  FilterInteractorTests.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import XCTest
@testable import BreakingBad

class FilterInteractorTests: XCTestCase {
    
    var sut: FilterInteractor!
    var mockFilterResults: MockFilterResults!
    var mockFilterInteractorOutput: MockFilterInteractorOutput!
    
    override func setUp() {
        super.setUp()
        mockFilterResults = MockFilterResults()
        mockFilterInteractorOutput = MockFilterInteractorOutput()
        sut = FilterInteractor(selectedSeasons: nil, delegate: mockFilterResults)
        sut.output = mockFilterInteractorOutput
    }
    
    override func tearDown() {
        mockFilterResults = nil
        mockFilterInteractorOutput = nil
        sut = nil
        super.tearDown()
    }
    
    func testShouldAddSeason() {
        sut.seasonSelected(2)
        XCTAssertEqual(sut.selectedSeasons.count, 1)
    }
    
    func testShouldNotAddDuplicateSeason() {
        sut.seasonSelected(2)
        XCTAssertEqual(sut.selectedSeasons.count, 1)
        sut.seasonSelected(2)
        XCTAssertEqual(sut.selectedSeasons.count, 1)
    }
    
    func testShouldRemoveSeason() {
        sut.seasonSelected(2)
        sut.seasonSelected(3)
        sut.seasonDeselected(2)
        XCTAssertEqual(sut.selectedSeasons.count, 1)
    }
    
    func testShouldReturnFilterSeasons() {
        sut.seasonSelected(3)
        sut.seasonSelected(2)
        sut.filterSeasons()
        XCTAssert(mockFilterResults.seasons?.contains(3) ?? false)
        XCTAssert(mockFilterResults.seasons?.contains(2) ?? false)
    }
    
    func testShouldSetSelectedRowsWhenFetching() {
        sut.seasonSelected(2)
        sut.seasonSelected(3)
        _ = sut.fetchSeasons()
        XCTAssert(mockFilterInteractorOutput.didSelectRows.contains(1))
        XCTAssert(mockFilterInteractorOutput.didSelectRows.contains(2))
    }
}

class MockFilterResults: FilterResults {
    
    var seasons: [Int]?
    
    func seasonsSelected(_ seasons: [Int]) {
        self.seasons = seasons
    }
}

class MockFilterInteractorOutput: FilterInteractorOutput {
   
    var didSelectRows: [Int] = []
    
    func selectSeasonAtRow(_ row: Int) {
        didSelectRows.append(row)
    }
}

