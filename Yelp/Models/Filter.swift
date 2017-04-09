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
    
    // MARK: toggle the selected index of options
    var selectedIndex: Int = -1 {

        didSet {
            guard selectedIndex < self.options.count && selectedIndex > -1 else { return }
            var oldOption = self.options[selectedIndex]
            
            if self.allowMultiSelect {
                self.options[selectedIndex].toggle()
//                self.options[selectedIndex].isSelected = !self.options[selectedIndex].isSelected
            } else {
                
                if oldOption.isSelected {
                    self.options[selectedIndex].toggle()
//                    self.options[selectedIndex].isSelected = !oldOption.isSelected
                } else {
                    // see if any selected row, if yes, uncheck it -> make sure only one is selected at a time
                    for (index, _) in self.options.enumerated() {
                        if self.options[index].isSelected {
                            self.options[index].toggle()
                        }
                    }
                    self.options[selectedIndex].toggle()
//                    self.options[selectedIndex].isSelected = !self.options[selectedIndex].isSelected
                }
            }
            
            _lastSelected = selectedIndex
            print("num of selection: \(self.numOfSelected)")
        }
    }
    
    var numOfSelected: Int {
        get {
//            return self.options.filter {
//                return $0.isSelected
//            }.count
            
            return self.options.reduce(0) { return $0 + ($1.isSelected ? 1 : 0) }
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
    
    internal mutating func changeOption(at index: Int, to value: Bool) -> Filter {
        guard index >= 0 && index < self.options.count else {
            return self
        }
        var option = options[index]
        self.options[index] = option.change(selected: value)
        return self
    }
    
    internal func getSelectedOptions() -> [Option] {
        return self.options.filter {
            return $0.isSelected
        }
    }
}
