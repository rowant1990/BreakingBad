//
//  FilterTableViewDelegate.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterTableViewDelegate: NSObject, UITableViewDelegate {
    
    var seasons: [Int] = []
    weak var selection: FilterSelection?
     
     init(selection: FilterSelection?) {
         self.selection = selection
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?.seasonSelected(seasons[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selection?.seasonDeselected(seasons[indexPath.row])
    }
}

