//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by megared on 18/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var firstCityName: UILabel!
    @IBOutlet weak var firstCityTemperature: UILabel!
    @IBOutlet weak var firstCityWeather: UILabel!
    @IBOutlet weak var secondCityName: UILabel!
    @IBOutlet weak var secondCityTemperature: UILabel!
    @IBOutlet weak var secondCityWeather: UILabel!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to is true color
        setOriginalImage()
        // Get weather infos
        getCityWeather()
    }
    
    //MARK: - Functions
    /// Get weather infos
    private func getCityWeather() {
        WeatherService.shared.getWeather { (success, cityWeather) in
            if success, let cityWeather = cityWeather {
                self.update(cityWeather: cityWeather)
            } else {
                self.presentAlert()
            }
        }
    }
    
    /// Update weather infos
    private func update(cityWeather: CityWeather) {
        firstCityName.text = cityWeather.list[0].name
        firstCityTemperature.text = "\(Int(round(cityWeather.list[0].main.temp)))°C"
        firstCityWeather.text = cityWeather.list[0].weather[0].description
        secondCityName.text = cityWeather.list[1].name
        secondCityTemperature.text = "\(Int(round(cityWeather.list[1].main.temp)))°C"
        secondCityWeather.text = cityWeather.list[1].weather[0].description
    }
    
    /// Alert pop up message
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Today sync of weather failed", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
