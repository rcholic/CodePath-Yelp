//
//  UserLocation.swift
//  Yelp
//
//  Created by Guoliang Wang on 4/10/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import CoreLocation

// KVO pattern: https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-XID_8

//internal class Coordinate: NSObject {
//    var longitude: Double = 0.0
//    var latitude: Double = 0.0
//}
class UserLocation: NSObject, CLLocationManagerDelegate {
    
//    dynamic var coordinate: Coordinate? = nil
    
    public static let shared = UserLocation()
    
    private let manager: CLLocationManager = CLLocationManager()
    
    private var longitude: Double {
        get {
            return manager.location?.coordinate.latitude ?? -122.40641700
        }
    }
    
    private var latitude: Double {
        get {
            return manager.location?.coordinate.longitude ?? 37.78583400
        }
    }
    
    private override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager error: \(error.localizedDescription)")
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard locations.count > 0 else {
            return
        }
        let location = locations.last! as CLLocation
        print("location manager reeived location: \(location)")
//        latitude = location.coordinate.latitude
//        longitude = location.coordinate.longitude
        // TODO: what to do when user's location changes?
        manager.stopUpdatingLocation()
    }
    
    internal func requestLocation() {
        manager.requestLocation()
    }
    
    
}
