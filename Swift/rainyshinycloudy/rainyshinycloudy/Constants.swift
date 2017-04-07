//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Ari Mendelow on 3/31/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import Foundation

let BASE_URL_TODAY = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let lat = Location.sharedInstance.latitude
let LONGITUDE = "&lon="
let long = Location.sharedInstance.longitude
let APP_ID = "&appid="
let API_KEY = "bb63329c64fae1b49e8183752b6af4cf"

typealias DownloadComplete = () ->() //this is going to tell our function when we are done downloading. how? i dunno.

let CURRENT_WEATHER_URL = "\(BASE_URL_TODAY)\(LATITUDE)\(lat ?? 0.0)\(LONGITUDE)\(long ?? 0.0)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL_FORECAST)\(LATITUDE)\(lat ?? 0.0)\(LONGITUDE)\(long ?? 0.0)\(APP_ID)\(API_KEY)"

