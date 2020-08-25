//
//  UIViewController+Storyboard.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

extension UIViewController {
    static func fromStoryboard() -> Self {
        return UIStoryboard(name: "Main", bundle: Bundle(for: self))
            .instantiateViewController(withIdentifier: String(describing: self)) as! Self
    }
}
