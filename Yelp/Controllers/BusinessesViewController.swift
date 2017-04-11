//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import SnapKit

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    fileprivate let refreshControl = UIRefreshControl()
    
    fileprivate let searchBar = UISearchBar()
    
    fileprivate var searchFilter = YelpFilters() {
        didSet {
            if oldValue != searchFilter {
                NSLog("resetting offset")
                offset = 0 // reset offset
            }
        }
    }
    
    fileprivate let searchIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    fileprivate let cellIdentifier = "RestaurantCell"
//    fileprivate let cellIdentifier = "BusinessCell"
  
    fileprivate var referenceCell: RestaurantTableViewCell!
//    fileprivate var referenceCell: BusinessCell!
    
    fileprivate var searchTerm: String = "Asian"
    
    fileprivate var offset: Int = 0 // offset search results
    
    fileprivate var restaurants: [Restaurant] = [] // TODO: pagination in search?
    
    typealias stopIndicatorCallback = () -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableview()
//        search(term: searchTerm, params: searchFilter.parameters, callback: nil)
        searchYelp(sender: nil)
        
        UserLocation.shared.requestLocation()
    }
    
    @objc fileprivate func searchYelp(sender: AnyObject?) {
        
        var searchParams = searchFilter.parameters
        if offset > 0 {
            searchParams["offset"] = offset as AnyObject
        } else {
            searchParams.removeValue(forKey: "offset")
        }
        
        var callback: stopIndicatorCallback? = nil
        if let fromSender = sender, fromSender is UISearchBar {
            // callback to stop the spinner
            offset = 0 // reset for new search
            callback = {
                self.searchIndicator.stopAnimating()
            }
        }
        search(term: searchTerm, params: searchParams, callback: callback)
    }
    
    // MARK: working horse for making the search call
    private func search(term: String, params: [String: AnyObject], callback: stopIndicatorCallback?) {
        YelpAPIService.shared.searchWithParams(term: term, params: params) { (restaurants: [Restaurant], errorStr: String?, statusCode: Int?) in
            // TODO: warning when there's no more restaurants
            self.restaurants = restaurants
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
            
            if let cb = callback {
                cb() // trigger the callback
            }
        }
    }
    
    private func setupSearchBar() {

//        titleViewWidth  = navigationItem.titleView?.bounds.size.width
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        searchBar.insertSubview(searchIndicator, at: 0)
        searchIndicator.isHidden = true
        searchIndicator.hidesWhenStopped = true
        
        searchIndicator.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
    }
    
    private func setupTableview() {
        
        let cellNib = UINib(nibName: "RestaurantTableViewCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
//        let cellNib = UINib(nibName: "BusinessCell", bundle: Bundle.main)
//        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView() // don't show empt cells
        
        refreshControl.addTarget(self, action: #selector(self.loadMoreData(sender:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        referenceCell = cellNib.instantiate(withOwner: nil, options: nil).first as! RestaurantTableViewCell!
//        referenceCell = cellNib.instantiate(withOwner: nil, options: nil).first as! BusinessCell!
        referenceCell.frame = tableView.frame // tableView.estimatedRowHeight = 120
    }
    
    @objc private func loadMoreData(sender: UIRefreshControl?) {
        offset += restaurants.count // get next page of data
        searchYelp(sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is UINavigationController {
            let navVC = segue.destination as! UINavigationController
            if let filtersVC = navVC.viewControllers.first, let targetVC = filtersVC as? FiltersViewController {
                targetVC.delegate = self
                targetVC.viewModel = searchFilter
            }
        }
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

extension BusinessesViewController: FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: FiltersViewController, searchFilter: YelpFilters?) {
        if let filter = searchFilter {
            self.searchFilter = filter // update the search filter
            searchYelp(sender: nil)
        }
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.bringSubview(toFront: searchIndicator)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchIndicator.stopAnimating()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // do something if necessary
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search bar text changed: \(searchText)")
        
        if searchText.characters.count == 0 {
            searchIndicator.stopAnimating()
        } else {
            self.searchTerm = searchText // update the search term
            searchIndicator.isHidden = false
            if !searchIndicator.isAnimating {
                searchIndicator.startAnimating()
            }
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchYelp), object: nil)
            // throttle the API calls to Yelp search: 0.5 second
            self.perform(#selector(self.searchYelp), with: searchBar, afterDelay: 0.5)
        }
    }
}
