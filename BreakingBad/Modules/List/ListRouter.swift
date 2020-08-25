//
//  ListRouter.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit


class ListRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension ListRouter: ListWireframe {
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showCharacter(_ character: Character) {
        let detail = DetailModule.build(character: character)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
    
    func presentFilter(filterResults: FilterResults, selectedSeasons: [Int]?) {
        let filter = FilterModule.build(filterResults: filterResults, selectedSeasons: selectedSeasons)
        viewController?.present(filter, animated: true, completion: nil)
    }
}
