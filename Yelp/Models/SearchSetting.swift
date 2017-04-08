//
//  SearchSetting.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import Foundation


struct SearchSetting {
    
    var term: String
    
    var sortMode: YelpSortMode = .bestMatched
    
    var categories: [String] = []
    
    init(term: String) {
        self.term = term
    }
    
    public func getCategories() -> String? {
        if self.categories.count > 0 {
            return categories.joined(separator: ",")
        }
        return nil
    }
}
