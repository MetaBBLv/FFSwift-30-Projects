//
//  TodayViewController.swift
//  FFWeatherDemo
//
//  Created by zhou on 2019/7/29.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import NotificationCenter
import WeatherKit

class TodayViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    fileprivate var isFetched = false
    fileprivate var location = "San Francisco, U.S."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.preferredContentSize = CGSize(width: UIScreen.main.applicationFrame.size.width, height: 37.0)
        
        displayCurrentWeather()
    }
    
    
    
    func displayCurrentWeather() {
        // Update location
        cityLabel.text = location
        
        // Inovoke weather service to get the weather data
        WeatherService.sharedWeatherService().getCurrentWeather(location, completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                guard let weatherData = data else {
                    self.isFetched = false
                    return
                }
                self.isFetched = true
                self.weatherLabel.text = weatherData.weather.capitalized
                self.tempLabel.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
            })
        })
    }
    
    func widgetPerformUpdate(completionHandle: (@escaping (NCUpdateResult) -> Void)) {
        if isFetched {
            completionHandle(NCUpdateResult.newData)
        } else {
            completionHandle(NCUpdateResult.noData)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
