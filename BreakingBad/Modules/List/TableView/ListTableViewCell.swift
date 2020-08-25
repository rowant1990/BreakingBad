//
//  ListTableViewCell.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var photoImageView: UIImageView? {
        didSet {
            photoImageView?.kf.indicatorType = .activity
        }
    }

    var name: String? {
        didSet {
            titleLabel.text = name
        }
    }
    
    var imagePath: String? {
        didSet {
            if let path = imagePath, let url = URL(string: path) {
                photoImageView?.kf.setImage(with: url, placeholder: UIImage(named: "logo"), options: [        .transition(.fade(1))
                ])
            } else {
                photoImageView?.image = nil
            }
        }
    }

}
