//
//  ListInteractor.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class ListInteractor {
    weak var output: ListInteractorOutput?
    let networkClient: NetworkClient
    let queue: ThreadExecutor
    private(set) var characters: [Character]?
    private(set) var selectedSeasons: [Int]?
    
    init(networkClient: NetworkClient, queue: ThreadExecutor = DispatchQueue.main) {
        self.networkClient = networkClient
        self.queue = queue
    }
}

extension ListInteractor: ListInteractorInput {
    func fetchCharacter() {
        let url = URL(string: "https://breakingbadapi.com/api/characters")!
        networkClient.fetch(url: url) { [weak self] (result: Result<[Character], Error>) in
            self?.queue.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters
                    self?.output?.charactersFound(characters)
                case .failure(let error):
                    self?.output?.errorReturned(error)
                }
            }
        }
    }
    
    func search(_ text: String) {
        guard let characters = characters else { return }
        self.output?.charactersFound(characters.filter({ $0.name.contains(text) }))
    }
    
    func reset() {
        guard let characters = characters else { return }
        if let selectedSeasons = selectedSeasons {
            filter(selectedSeasons)
        } else {
            output?.charactersFound(characters)
        }
    }
    
    func filter(_ seasons: [Int]) {
        guard let characters = characters else { return }
        selectedSeasons = seasons
        output?.charactersFound(characters.filter({ Set(seasons).isSubset(of: $0.appearance) }))
    }
}

