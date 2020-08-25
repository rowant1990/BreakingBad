//
//  ListPresenter.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class ListPresenter: ListUser {
    
    let wireframe: ListWireframe
    var interactor: ListInteractorInput?
    weak var ui: ListUI?
    
    init(wireframe: ListWireframe) {
        self.wireframe = wireframe
    }
    
    func arrived() {
        interactor?.fetchCharacter()
    }
    
    func search(_ text: String) {
        interactor?.search(text)
    }
    
    func dismissedSearch() {
        interactor?.reset()
    }
    
    func filter() {
        wireframe.presentFilter(filterResults: self, selectedSeasons: interactor?.selectedSeasons)
    }
}

extension ListPresenter: CharacterSelection {
    func characterSelected(_ character: Character) {
        wireframe.showCharacter(character)
    }
}

extension ListPresenter: FilterResults {
    func seasonsSelected(_ seasons: [Int]) {
        interactor?.filter(seasons)
    }
}

extension ListPresenter: ListInteractorOutput {
    func charactersFound(_ characters: [Character]) {
        ui?.loadCharacters(characters)
    }
    
    func errorReturned(_ error: Error) {
        wireframe.showError(error)
    }
}
