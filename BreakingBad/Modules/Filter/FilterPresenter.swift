//
//  FilterPresenter.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterPresenter {
    
    let wireframe: FilterWireframe
    var interactor: FilterInteractorInput?
    weak var ui: FilterUI?
    
    init(wireframe: FilterWireframe) {
        self.wireframe = wireframe
    }
}

extension FilterPresenter: FilterSelection {
    func seasonSelected(_ season: Int) {
        interactor?.seasonSelected(season)
    }
    
    func seasonDeselected(_ season: Int) {
        interactor?.seasonDeselected(season)
    }
}

extension FilterPresenter: FilterUser {
    
    func arrived() {
        guard let seasons = interactor?.fetchSeasons() else { return }
        ui?.loadSeasons(seasons)
    }
    
    func cancel() {
        wireframe.close()
    }
    
    func done() {
        interactor?.filterSeasons()
        wireframe.close()
    }
}

extension FilterPresenter: FilterInteractorOutput {
    
    func selectSeasonAtRow(_ row: Int) {
        ui?.selectRow(row)
    }
}
