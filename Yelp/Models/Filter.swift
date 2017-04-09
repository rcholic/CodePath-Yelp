//
//  Filter.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/8/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

internal enum FilterType {
    case single
    case dropDown
    case list
}

// MARK: CellType - Cell Identifier associated enum
internal enum CellType: String {
    case switchCell = "SwitchCell"
    case optionCell = "OptionCell"
}

internal struct Filter {
    
    let label: String
    let code: String
    let type: FilterType
    let numItemsVisible: Int?
    let allowMultiSelect: Bool
    let cellType: CellType
    var options: [Option] = []
    var isCollapsed: Bool = false
    var _lastSelected: Int = -1
    
    // MARK: toggle the selected index
    var selectedIndex: Int = -1 {

        didSet {
            guard selectedIndex < self.options.count && selectedIndex > -1 else { return }
            
            self.options[selectedIndex].isSelected = !self.options[selectedIndex].isSelected
            
//            if self.allowMultiSelect {
//                self.options[selectedIndex].isSelected = !self.options[selectedIndex].isSelected
//            } else {
//                
//                let oldOption = self.options[selectedIndex]
//                if oldOption.isSelected {
//                    self.options[selectedIndex].isSelected = !oldOption.isSelected
//                } else {
//                    // see if any selected row
//                    let selectedOptions = self.options.filter {
//                        return $0.isSelected
//                    }
//                    for (index, _) in selectedOptions.enumerated() {
//                        selectedOptions[index].isSelected = false
//                    }
//                    
//                    self.options[selectedIndex].isSelected = !self.options[selectedIndex].isSelected
//                }
//            }
            
            _lastSelected = selectedIndex
            print("num of selection: \(self.numOfSelected)")
        }
    }
    
    var numOfSelected: Int {
        get {
            return self.options.filter {
                return $0.isSelected
            }.count
            
//            return self.options.reduce(0) { return $0 + ($1.isSelected ? 1 : 0) }

        }
    }
    
    // MARK: Each filter has a cell type specified, defaulted to SwitchCell
    init(label: String, code: String, type: FilterType, numItemsVisible: Int?, options: [Option], allowMultiSelect: Bool, isCollapsed: Bool, cellType: CellType = .switchCell) {
        self.label = label
        self.code = code
        self.type = type
        self.options = options
        self.numItemsVisible = numItemsVisible
        self.allowMultiSelect = allowMultiSelect
        self.isCollapsed = isCollapsed
        self.cellType = cellType        
    }
    
    internal func getSelectedOptions() -> [Option] {
        return self.options.filter {
            return $0.isSelected
        }
    }
}

//internal struct Option {
//    
//    let label: String
//    let value: String
//    var isSelected: Bool
//    
//    init(label: String, value: String, isSelected: Bool) {
//        
//        self.label = label
//        self.value = value
//        self.isSelected = isSelected
//    }
//    
//    mutating func toggleSelection() -> Option {
//        self.isSelected = !isSelected
//        
//        return self
//    }
//}

internal class Option: NSObject {
    
    let label: String
    let value: String
    var isSelected: Bool
    
    init(label: String, value: String, isSelected: Bool) {
        
        self.label = label
        self.value = value
        self.isSelected = isSelected
        super.init()
    }
}

