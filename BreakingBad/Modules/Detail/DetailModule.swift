//
//  DetailProtocols.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

struct DetailModule {

    static func build(character: Character) -> DetailViewController {
        let interactor = DetailInteractor(character: character)

        let view  = DetailViewController.fromStoryboard()
        let presenter = DetailPresenter()

        view.user = presenter

        interactor.output = presenter

        presenter.interactor = interactor
        presenter.ui = view

        return view
    }
}

protocol DetailUser: class {
    func arrived()
}

protocol DetailUI: class {
    func loadRows(_ rows: [DetailRow])
    func loadImage(_ path: String)
}

protocol DetailInteractorInput: class {
    func loadCharacter()
    func loadRows() -> [DetailRow]
}

protocol DetailInteractorOutput: class {
    func loadImage(_ path: String)
}

