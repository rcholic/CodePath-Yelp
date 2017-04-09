//
//  Option.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation

internal struct Option {
    
    let label: String
    let value: String
    var isSelected: Bool
    
    init(label: String, value: String, isSelected: Bool) {
        
        self.label = label
        self.value = value
        self.isSelected = isSelected
    }
    
    mutating func toggle() {
        self.isSelected = !self.isSelected
        //        self = Option(label: label, value: value, isSelected: !isSelected)
    }
    
    mutating func change(selected toValue: Bool) -> Option {
        //        self.isSelected = toValue
        return Option(label: label, value: value, isSelected: toValue)
    }
}

//internal class Option: NSObject {
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
//        super.init()
//    }
//
//    internal func toggle() {
//        self.isSelected = !self.isSelected
//    }
//}
