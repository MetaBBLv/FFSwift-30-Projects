//
//  FFMasterTableViewController.swift
//  FFCandyScarch
//
//  Created by zhou on 2019/6/28.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFMasterTableViewController: UITableViewController {
    
    //MARK: - Properties
    var detailViewController: FFDetailViewController? = nil
    var candies = [FFCandy]()
    var filteredCandies = [FFCandy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - View SetUp
    override func viewDidLoad() {
        super.viewDidLoad()

        candies = [
            FFCandy(category: "Chocolate", name: "Chocolate Bar"),
            FFCandy(category: "Chocolate", name: "Chocolate Chip"),
            FFCandy(category: "Chocolate", name: "Dark Chocolate"),
            FFCandy(category: "Hard", name: "Lollipop"),
            FFCandy(category: "Hard", name: "Candy Cane"),
            FFCandy(category: "Hard", name: "Jaw Breaker"),
            FFCandy(category: "Other", name: "Caramel"),
            FFCandy(category: "Other", name: "Sour Chew"),
            FFCandy(category: "Other", name: "Gummi Bear")
        ]
        
        setupSearchController()
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? FFDetailViewController
            
        }
    }
    
    //MARK: - Search Controller SetUp
    func setupSearchController () {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchController.searchBar.delegate = self
        
        if #available(iOS 11, *) {
            self.navigationItem.searchController = searchController
            self.navigationItem.searchController?.isActive = true
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({ (FFCandy) -> Bool in
            if !(FFCandy.category == scope) && scope != "All" {
                return false
            }
             return FFCandy.name.lowercased().contains(searchText.lowercased()) || searchText == ""
        })
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return filteredCandies.count
        }
        return candies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let candy: FFCandy
        if searchController.isActive {
            candy = filteredCandies[(indexPath as NSIndexPath).row]
        } else {
            candy = candies[(indexPath as NSIndexPath).row]
        }
        cell.textLabel!.text = candy.name
        cell.detailTextLabel?.text = candy.category

        return cell
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let candy: FFCandy
                if searchController.isActive {
                    candy = filteredCandies[(indexPath as NSIndexPath).row]
                } else {
                    candy = candies[(indexPath as NSIndexPath).row]
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! FFDetailViewController
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
            }
        }
    }
}

extension FFMasterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension FFMasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
