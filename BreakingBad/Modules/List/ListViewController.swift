//
//  ViewController.swift
//  BreakingBad
//
//  Created by Rowan Townshend on 24/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var user: (ListUser & CharacterSelection)?
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = tableDataSource
            tableView.delegate = tableDelegate
        }
    }
    private let tableDataSource = ListTableDataSource()
    private lazy var tableDelegate = ListTableViewDelegate(selection: self)
    
    lazy var searchController: UISearchController = {
        let searchVc = UISearchController(searchResultsController: nil)
        searchVc.searchResultsUpdater = self
        searchVc.obscuresBackgroundDuringPresentation = false
        searchVc.searchBar.placeholder = "Search"
        searchVc.delegate = self
        return searchVc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        definesPresentationContext = true
        user?.arrived()
    }
    
    @IBAction func filterPressed(_ sender: UIButton) {
        user?.filter()
    }
}

extension ListViewController: CharacterSelection {
    func characterSelected(_ character: Character) {
        user?.characterSelected(character)
    }
}

extension ListViewController: ListUI {
    func loadCharacters(_ characters: [Character]) {
        tableDataSource.characters = characters
        tableDelegate.characters = characters
        tableView.reloadData()
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        user?.search(searchBar.text!)
    }
}

extension ListViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        user?.dismissedSearch()
    }
}
