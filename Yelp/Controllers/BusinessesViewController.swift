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
    
    var referenceCell: RestaurantTableViewCell!
    
    let cellIdentifier = "RestaurantCell"
    
    var restaurants: [Restaurant] = [] // TODO: pagination in search?
    
    var searchSettings = SearchSetting(term: "Chinese")
    
    private var windowSize: CGSize {
        get {
            return self.view.bounds.size
        }
    }
    
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
        
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: windowSize.width, height: 0.1))
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView() // don't show empt cells
        
        referenceCell = cellNib.instantiate(withOwner: nil, options: nil).first as! RestaurantTableViewCell!
        referenceCell.frame = tableView.frame // tableView.estimatedRowHeight = 120
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
    
    // automatic height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        referenceCell.restaurant = restaurants[indexPath.row]
        referenceCell.layoutSubviews()
        return referenceCell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
//        return referenceCell.systemLayoutSizeFitting(CGSize, withHorizontalFittingPriority: UILayoutPriority, verticalFittingPriority: <#T##UILayoutPriority#>)
        
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
