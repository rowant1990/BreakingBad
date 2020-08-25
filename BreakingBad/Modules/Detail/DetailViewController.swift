//
//  DetailViewController.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = tableDataSource
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 60
        }
    }
    
    var user: DetailUser?
    private let tableDataSource = DetailTableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user?.arrived()
    }
}

extension DetailViewController: DetailUI {
    func loadImage(_ path: String) {
        if let url = URL(string: path) {
            imageView.kf.setImage(with: url)
        }
    }
    
    func loadRows(_ rows: [DetailRow]) {
        tableDataSource.rows = rows
    }
}
