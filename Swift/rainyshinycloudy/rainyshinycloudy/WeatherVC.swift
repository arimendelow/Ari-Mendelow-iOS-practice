//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Ari Mendelow on 3/21/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate { //delegate tells the table how to handle date; data source is where the data comes from
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var currentWeather: CurrentWeather! //create generic class of CurrentWeather
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() //can request always or when in use - we did in use
        locationManager.startMonitoringSignificantLocationChanges() //keeps track of any significant location changes
        
        //need to do this to actually show the cells and stuff
        tableView.delegate = self //we want the tableView to be its own delegate
        tableView.dataSource = self //same as above
        
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation!.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation!.coordinate.longitude
            print("\(currentLocation!.coordinate.latitude)")
            print("\(currentLocation!.coordinate.longitude)")
            //and our location is now available throughout the app via the static var in our Location class
            
            currentWeather.downloadWeatherDetails{
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }

        } else {
            locationManager.requestWhenInUseAuthorization() //if not yet authorized, ask for authorization
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //downloading forecast weather for TableView
//        let forecastURL = URL(string: FORECAST_URL)
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
//                    self.forecasts.remove(at: 0) //if you want to remove the first day in the TableView (today)
                    self.tableView.reloadData() //need to reload the tableView so it'll show
                }
                
            }
            
        }
        completed()
    }
    
    
    //three main tableView functions:
        //numberOfSections
        //numberOfRows..
        //cellForRow..
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //just one section
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count //however many days we're getting
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell { //looks for cell with that identifer, uses it to create the other cells
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell //we need to return a cell, otherwise it wont know what to actually do with this cell we just created
            
        } else { //in case cell is empty, dont want app to crash
            return WeatherCell()
        }
        
    }
 
    func updateMainUI() {
        
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)º"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }

}

