//
//  ListProtocols.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

protocol ListWireframe: class {
    func presentFilter(filterResults: FilterResults, selectedSeasons: [Int]?)
    func showCharacter(_ character: Character)
    func showError(_ error: Error)
}

protocol ListUser: class {
    func arrived()
    func search(_ text: String)
    func dismissedSearch()
    func filter()
}

protocol ListUI: class {
    func loadCharacters(_ characters: [Character])
}

protocol ListInteractorInput: class {
    var selectedSeasons: [Int]? { get }
    func fetchCharacter()
    func search(_ text: String)
    func reset()
    func filter(_ seasons: [Int])
}

protocol ListInteractorOutput: class {
    func charactersFound(_ characters: [Character])
    func errorReturned(_ error: Error)
}

protocol CharacterSelection: class {
    func characterSelected(_ character: Character)
}

class ListModule {
    
    static func build(networkClient: NetworkClient) -> ListViewController {
        let interactor = ListInteractor(networkClient: networkClient)
     
        let view = ListViewController.fromStoryboard()
        let router = ListRouter(viewController: view)
        let presenter = ListPresenter(wireframe: router)
        
        view.user = presenter
        
        interactor.output = presenter
        
        presenter.interactor = interactor
        presenter.ui = view
        
        return view
    }
}
