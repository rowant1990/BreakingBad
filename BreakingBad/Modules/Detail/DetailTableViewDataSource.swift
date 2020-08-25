//
//  DetailTableViewDataSource.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class DetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    var rows: [DetailRow] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self)) as! DetailTableViewCell
        let row = rows[indexPath.row]
        cell.content = row.content
        cell.title = row.title
        return cell
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
}
