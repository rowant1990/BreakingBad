//
//  ListTableDataSource.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class ListTableDataSource: NSObject, UITableViewDataSource {
    
    var characters: [Character] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self)) as! ListTableViewCell
        let character = characters[indexPath.row]
        cell.name = character.name
        cell.imagePath = character.imagePath
        return cell
    }
    
    
}
