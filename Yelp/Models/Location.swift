//
//  Location.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import ObjectMapper

class Location: BaseJsonModel {
    
    var address: [String?] = []
    var city: String?
    var coordinate: [String: Float?] = [:]
    var countryCode: String?
    var crossStreets: String?
    var displayAddress: [String?] = []
    var geoAccuracy: Float?
    var neighborhoods: [String?] = []
    var postalCode: String?
    var stateCode: String?
    
    override func mapping(map: Map) {
        address <- map["address"]
        city <- map["city"]
        coordinate <- map["coordinate"]
        countryCode <- map["country_code"]
        crossStreets <- map["cross_streets"]
        displayAddress <- map["display_address"]
        geoAccuracy <- map["geo_accuracy"]
        neighborhoods <- map["neighborhoods"]
        postalCode <- map["postal_code"]
        stateCode <- map["state_code"]
    }
}
