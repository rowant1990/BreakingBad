//
//  FilterModule.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

protocol FilterWireframe: class {
    func close()
}

protocol FilterUser: class {
    func arrived()
    func cancel()
    func done()
}

protocol FilterUI: class {
    func loadSeasons(_ seasons: [Int])
    func selectRow(_ row: Int)
}

protocol FilterInteractorInput: class {
    func fetchSeasons() -> [Int]
    func filterSeasons()
    func seasonSelected(_ season: Int)
    func seasonDeselected(_ season: Int)
}

protocol FilterInteractorOutput: class {
    func selectSeasonAtRow(_ row: Int)
}

protocol FilterResults: class {
    func seasonsSelected(_ seasons: [Int])
}

protocol FilterSelection: class {
    func seasonSelected(_ season: Int)
    func seasonDeselected(_ season: Int)
}


struct FilterModule {
    
    static func build(filterResults: FilterResults, selectedSeasons: [Int]?) -> UIViewController {
        let interactor = FilterInteractor(selectedSeasons: selectedSeasons, delegate: filterResults)
        
        let view  = FilterViewController.fromStoryboard()
        let router = FilterRouter(viewController: view)
        let presenter = FilterPresenter(wireframe: router)
        
        view.user = presenter
        
        interactor.output = presenter
        
        presenter.interactor = interactor
        presenter.ui = view
        
        let nav = UINavigationController(rootViewController: view)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
