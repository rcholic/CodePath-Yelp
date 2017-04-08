//
//  YelpAPIService.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/7/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

// autolayout video II: https://www.youtube.com/watch?v=sgqlFm8vdwo&list=PLrT2tZ9JRrf7p1AoQ0C7APLImJjdUiEbA&index=3
/*
 mapview: https://guides.codepath.com/ios/Maps
 tableview auto height: http://guides.codepath.com/ios/Table-View-Guide#variable-row-height
 
 basic filters: https://www.youtube.com/watch?v=sgqlFm8vdwo&list=PLrT2tZ9JRrf7p1AoQ0C7APLImJjdUiEbA&index=3
 
 */

import AFNetworking
import SwiftyJSON
import ObjectMapper
import BDBOAuth1Manager

//let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
//let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
//let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
//let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
//
//enum YelpSortMode: Int {
//    case bestMatched = 0, distance, highestRated
//}

typealias CompletionHandler = (_: [Restaurant], _ error: String?, _ statusCode: Int?) -> Void
class YelpAPIService: BDBOAuth1RequestOperationManager {
    
    public static let shared = YelpAPIService(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
    
//    private let manager = AFHTTPSessionManager()
    
    private let accessToken: String
    
    private let accessSecret: String
    
    private init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        
        let baseUrl = URL(string: "https://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret)
        
        let token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchWithTerm(term: String, sort: YelpSortMode?, categories: [String]?, deals: Bool?, completionCallback: @escaping CompletionHandler) {
        
        var restaurants: [Restaurant] = []
        
        // Default the location to San Francisco
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "ll": "37.785771,-122.406165" as AnyObject]
        
        if sort != nil {
            parameters["sort"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["category_filter"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if deals != nil {
            parameters["deals_filter"] = deals! as AnyObject?
        }
        
        self.get("search", parameters: parameters, success: { (operation: AFHTTPRequestOperation, response: Any) in
//                print("response: \(response)")
            let json = JSON(response)
            let businesses = json["businesses"].arrayObject
            if let data = Mapper<Restaurant>().mapArray(JSONObject: businesses) {
                restaurants = data
                print("converted restaurants first address: \(restaurants.first?.address.joined(separator: ", "))")
                completionCallback(restaurants, nil, nil)
            }

        }) { (operation: AFHTTPRequestOperation?, error: Error) in
            print("error: \(error)")
            var statusCode = 400
            if let res = operation?.response {
                statusCode = res.statusCode
            }
            completionCallback(restaurants, error.localizedDescription, statusCode)
        }
    }
    
}

