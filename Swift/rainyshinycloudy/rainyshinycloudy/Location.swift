//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Ari Mendelow on 4/1/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
