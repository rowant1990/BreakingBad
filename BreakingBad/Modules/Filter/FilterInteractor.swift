//
//  FilterInteractor.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterInteractor {
    
    let seasons: Int
    weak var delegate: FilterResults?
    weak var output: FilterInteractorOutput?
    private(set) var selectedSeasons: Set<Int>

    init (seasons: Int = 5, selectedSeasons: [Int]?, delegate: FilterResults) {
        self.seasons = seasons
        self.delegate = delegate
        self.selectedSeasons = Set(selectedSeasons ?? [])
    }
}

extension FilterInteractor: FilterInteractorInput {
    func seasonSelected(_ season: Int) {
        selectedSeasons.insert(season)
    }
    
    func seasonDeselected(_ season: Int) {
        selectedSeasons.remove(season)
    }
    
    func filterSeasons() {
        delegate?.seasonsSelected(Array(selectedSeasons))
    }
    
    func fetchSeasons() -> [Int] {
        selectedSeasons.forEach({ output?.selectSeasonAtRow($0 - 1) })
        return Array(1...seasons).map({ $0 })
    }
}
