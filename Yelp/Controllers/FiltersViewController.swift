//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate: class {
    func filtersViewController(filtersViewController: FiltersViewController, searchFilter: YelpFilters?)
}

class FiltersViewController: UIViewController {

    var viewModel: YelpFilters?
    
    weak var delegate: FiltersViewControllerDelegate?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = YelpFilters()
        }

        setupTableView()
        self.tableView.reloadData()
    }
    
    @IBAction func didCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        delegate?.filtersViewController(filtersViewController: self, searchFilter: nil)
    }
    
    
    @IBAction func didSearch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        delegate?.filtersViewController(filtersViewController: self, searchFilter: viewModel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.reloadData()
    }

}

extension FiltersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel!.filters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let curFilter = viewModel!.filters[section]
        if curFilter.type == .single {
            return 1
        } else if curFilter.type == .dropDown {
            return curFilter.isCollapsed ? curFilter.options.count : 1
        }

                // show list
//        if let numVisibleCells = curFilter.numItemsVisible, numVisibleCells > 0 && numVisibleCells <  curFilter.options.count {
//            return numVisibleCells + 1
//        }
        return curFilter.options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let curFilter = viewModel!.filters[section]
        let label = curFilter.label
        
        if curFilter.allowMultiSelect && curFilter.numOfSelected > 0 {
            return "\(label): \(curFilter.numOfSelected) Selected"
        }
        
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let curFilter = viewModel!.filters[section]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        let checkedImageView = UIImageView(image: checkedImage)
        checkedImageView.tintColor = YELP_RED.withAlphaComponent(0.8)
        let uncheckedImageImageView = UIImageView(image: uncheckedImage)
        uncheckedImageImageView.tintColor = UIColor.lightGray
        
        let option = curFilter.options[indexPath.row]
        cell.textLabel?.text = option.label
        cell.accessoryView = option.isSelected ? checkedImageView : uncheckedImageImageView

        if curFilter.type == .dropDown {            
            if !curFilter.isCollapsed {
                let dropDownImageView = UIImageView(image: dropdownImage)
                dropDownImageView.tintColor = YELP_RED.withAlphaComponent(0.8)
                cell.accessoryView = dropDownImageView
            }
        } else {
            // if curFilter.type == .single || curFilter.type == .list
            
            if curFilter.cellType == .switchCell {
                let switchButton = UISwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
                switchButton.isOn = option.isSelected
                switchButton.onTintColor = UIColor(red: 73.0/255.0, green: 134.0/255.0, blue: 231.0/255.0, alpha: 1.0)
                switchButton.tag = indexPath.row // add a tag
                switchButton.addTarget(self, action: #selector(self.didChangeSwitchValue(sender:)), for: .valueChanged)
                
                cell.accessoryView = switchButton
            }
        }
        
        return cell
    }
    
    @objc private func didChangeSwitchValue(sender: UISwitch) {
        
        if let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            guard indexPath.section < viewModel!.filters.count else { return }
            let curFilter = viewModel!.filters[indexPath.section]
            guard indexPath.row < curFilter.options.count else { return }
//            curFilter = curFilter.changeOption(at: indexPath.row, to: sender.isOn) // does not work right
            viewModel!.filters[indexPath.section].selectedIndex = indexPath.row

            var title = "\(curFilter.label)"
            let numSelected = viewModel!.filters[indexPath.section].numOfSelected
//            let numSelected = curFilter.numOfSelected
            title += numSelected > 0 ? ": \(numSelected) Selected" : ""

            self.tableView.headerView(forSection: indexPath.section)?.textLabel?.text = "\(title)" // update header title
            self.tableView.headerView(forSection: indexPath.section)?.textLabel?.sizeToFit()
            
        }
    }
}

extension FiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let section = indexPath.section
        var curFilter = viewModel!.filters[section]

        if curFilter.type == .dropDown {
            
            if curFilter.isCollapsed {
                viewModel!.filters[section].selectedIndex = indexPath.row
                tableView.reloadRows(at: [indexPath], with: .automatic)
                
                if viewModel!.filters[section].numOfSelected > 0 {
                    // close dropdown when one option is selected
                    viewModel!.filters[section].isCollapsed = false
                }
            } else {
                // collapse dropdown
                viewModel!.filters[section].selectedIndex = -1 // do not unselect the first option by setting -1 here
                viewModel!.filters[section].isCollapsed = true
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                self.tableView.reloadSections([section], with: .automatic)
            })
        }
    }
}
