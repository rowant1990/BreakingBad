//
//  FilterRouter.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterRouter {
    
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension FilterRouter: FilterWireframe {
    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
