//
//  FilterTableViewDataSource.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit


class FilterTableViewDataSource: NSObject, UITableViewDataSource {
    
    var seasons: [Int] = []
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self)) as! FilterTableViewCell
        let character = seasons[indexPath.row]
        cell.season = character
        return cell
    }
}

