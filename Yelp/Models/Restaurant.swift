//
//  Restaurant.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import ObjectMapper
// API: https://www.yelp.com/developers/documentation/v2/search_api


class Restaurant: BaseJsonModel {
    
    var name: String?
    var imageUrl: String?
    var categories: [[String]] = []
    var location: Location? = nil
    var distance: Float?
    var ratingImageUrl: String?
    var reviewCount: Int?
    var rating: Float?
    
    override func mapping(map: Map) {
        name <- map["name"]
        imageUrl <- map["image_url"]
        categories <- map["categories"]
        location <- map["location"]
        distance <- map["distance"]
        ratingImageUrl <- map["rating_img_url"]
        reviewCount <- map["review_count"]
        rating <- map["rating"]
    }
    
    // read-only computed address
    var address: [String] {
        get {
            var addr: [String] = []
            
            guard let locatedAt = self.location else { return addr }
            
            guard let address = locatedAt.address.first else { return addr }
            
            addr += [address ?? ""]
            
            if let neighborhood = locatedAt.neighborhoods.first {
                addr += [neighborhood ?? ""]
            }
            
//            if let city = locatedAt.city {
//                addr += [city]
//            }
            
//            if let state = locatedAt.stateCode {
//                result += " \(state) \(locatedAt.postalCode ?? "")\n"
//            }
//            
//            if let country = locatedAt.countryCode {
//                result += " \(country)"
//            }
            
            return addr
        }
    }
}
