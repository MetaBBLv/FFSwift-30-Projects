//
//  ViewController.swift
//  FFWeatherDemo
//
//  Created by zhou on 2019/7/29.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import WeatherKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabe: UILabel!
    
    var city = "San Francisco"
    var country = "U.S."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherLabel.text = ""
        temperatureLabe.text = ""
        displayCurrentWeather()
    }

    func displayCurrentWeather() {
        // Update location
        cityLabel.text = city
        countryLabel.text = country
        
        // Invoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(city + "," + country, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let weatherData = data {
                    self.weatherLabel.text = weatherData.weather.capitalized
                    self.temperatureLabe.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                }
            })
            
        })
    }

    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
    }
    @IBAction func updateWeatherInfo(_ segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! LocationTableViewController
        var selectedLocation = sourceViewController.selectedLocation.split{ $0 == ","}.map {String($0)}
        city = selectedLocation[0]
        country = selectedLocation[1].trimmingCharacters(in: CharacterSet.whitespaces)
        displayCurrentWeather()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view countroller using [Segue destinationViewController]
        // Pass the selected Object to the new view Controller
        if segue.identifier == "showLocations" {
            let destinationController = segue.destination as! UINavigationController
            let locationTableViewController = destinationController.viewControllers[0] as! LocationTableViewController
            locationTableViewController.selectedLocation = "\(city), \(country)"
            
            
        }
    }
}

