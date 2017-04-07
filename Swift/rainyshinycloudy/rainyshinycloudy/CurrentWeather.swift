//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Ari Mendelow on 3/31/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit
import Alamofire //if you want to use a pod, you just import it

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: Int!
    
    //data encaptulation yay
    var cityName: String {
        if _cityName == nil {
            _cityName = "" //if it's nil, it'll probably crash, so we're gunna make sure it's never nil
        }
        return _cityName
    }
    
    //for date, it's a little different
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter() //giving the date a style
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date()) //creating a string of the current date, the date formatter is keeping track of how it looks
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Int {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        
        //Alamofire download
//        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)! //we need to force unwrap it to sortof prove that it's there
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { //removed completion handler because we dont need it, we already created a completion function
            
            responce in
            
            let result = responce.result //now we've saved the JSON that we want
            
            //creating dictionary to handle the JSON
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String { //searches JSON dictionary for "name" key
                    self._cityName = name.capitalized //makes sure that first name is always capitalized, no matter what
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
            
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemp = main["temp"] as? Double {
                        
                        let kelvinToFarenheightPreDivision = (currentTemp * 9/5) - 459.67
                        let kelvinToFarenheight = Int(round(10 * kelvinToFarenheightPreDivision/10))
                        
                        self._currentTemp = kelvinToFarenheight
                        print(self._currentTemp)
                        
                    }
                    
                }
                
            }
         completed()
        }
        
    }
    
    
    
    
    
}







