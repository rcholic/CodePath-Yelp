//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "RestaurantCell"
    
    var restaurants: [Restaurant] = [] // TODO: pagination in search?
    
    var searchSettings = SearchSetting(term: "Chinese")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        searchSettings.sortMode = .bestMatched
        search(settings: searchSettings)
    }
    
    private func search(settings: SearchSetting) {
        
        YelpAPIService.shared.searchWithTerm(term: settings.term, sort: settings.sortMode, categories: nil, deals: nil) { (restaurants: [Restaurant], errorStr: String?, statusCode: Int?) in
//            print("restaurants.count: \(restaurants.count)")
            self.restaurants = restaurants
            self.tableView.reloadData()
        }
    }
    
    private func setupTableview() {
        let cellNib = UINib(nibName: "RestaurantTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView() // don't show empt cells
    }
}

extension BusinessesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BusinessesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        cell.restaurant = restaurants[indexPath.row]
        
        return cell
    }
}
