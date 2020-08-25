//
//  DetailPresenter.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class DetailPresenter: DetailUser {
    
    weak var ui: DetailUI?
    var interactor: DetailInteractorInput?
    
    func arrived() {
        interactor?.loadCharacter()
        guard let rows = interactor?.loadRows() else { return }
        ui?.loadRows(rows)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func loadImage(_ path: String) {
        ui?.loadImage(path)
    }
}
