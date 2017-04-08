//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    let categoryCellId = "CategoryCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var categories: [[String:String]] = []
    
    fileprivate var selectedStates: [Bool]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = YelpAPIService.shared.yelpCategories()
        selectedStates = Array(repeating: false, count: categories.count)
        setupTableView()
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapOnSearch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let categoryCellNib = UINib(nibName: "CategorySwitchCell", bundle: Bundle.main)
        tableView.register(categoryCellNib, forCellReuseIdentifier: categoryCellId)
        
        tableView.reloadData()
    }

}

extension FiltersViewController: UITableViewDataSource, CategorySwitchCellDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategorySwitchCell
        cell.delegate = self
        
        let category = categories[indexPath.row]
        cell.countryLabel.text = category["name"]
        cell.switchButton.isOn = selectedStates[indexPath.row]
        return cell
    }
    
    func categorySwitchCell(cell: CategorySwitchCell, didChangeValue value: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            selectedStates[indexPath.row] = value
            print("toggle value: \(value) for index: \(indexPath.row)")
        }
    }
}

extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
