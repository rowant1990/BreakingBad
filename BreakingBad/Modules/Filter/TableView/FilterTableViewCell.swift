//
//  FilterTableTableViewCell.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet private var seasonLabel: UILabel!
    
    var season: Int? {
        didSet {
            if let season = season {
                seasonLabel.text = String(season)
            } else {
                seasonLabel.text = nil
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}
