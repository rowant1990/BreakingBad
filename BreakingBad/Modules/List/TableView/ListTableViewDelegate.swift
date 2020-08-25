//
//  ListTableViewDelegate.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class ListTableViewDelegate: NSObject, UITableViewDelegate {
    
    var characters: [Character]?
    weak var selection: CharacterSelection?
    
    init(selection: CharacterSelection?) {
        self.selection = selection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characters = characters else { return }
        selection?.characterSelected(characters[indexPath.row])
    }
}
