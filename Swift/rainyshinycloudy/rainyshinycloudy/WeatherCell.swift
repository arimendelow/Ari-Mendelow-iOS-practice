//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Ari Mendelow on 3/31/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell(forecast: Forecast) {
        
        weatherIcon.image = UIImage(named: "\(forecast.weatherType) Mini")
        dayLabel.text = forecast.date
        weatherType.text = forecast.weatherType
        highTemp.text = "\(forecast.highTemp)º"
        lowTemp.text = "\(forecast.lowTemp)º"
        
        
    }

}
