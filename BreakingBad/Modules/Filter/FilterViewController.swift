//
//  FilterViewController.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    var user: (FilterUser & FilterSelection)?
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.allowsMultipleSelection = true
            tableView.dataSource = tableViewDataSource
            tableView.delegate = tableViewDelegate
        }
    }
    private let tableViewDataSource = FilterTableViewDataSource()
    private lazy var tableViewDelegate = FilterTableViewDelegate(selection: user)

    override func viewDidLoad() {
        super.viewDidLoad()
        user?.arrived()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        user?.cancel()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        user?.done()
    }
}

extension FilterViewController: FilterUI {
    func selectRow(_ row: Int) {
        tableView.selectRow(at: IndexPath(row: row, section: 0), animated: false, scrollPosition: .none)
    }
    
    func loadSeasons(_ seasons: [Int]) {
        tableViewDataSource.seasons = seasons
        tableViewDelegate.seasons = seasons
    }
}
