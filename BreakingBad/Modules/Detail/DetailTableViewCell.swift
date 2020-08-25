//
//  DetailTableViewCell.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!

    var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = "\(title):"
            } else {
                titleLabel.text = nil
            }
        }
    }
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
}

struct DetailRow {
    let title: String
    let content: String
}
