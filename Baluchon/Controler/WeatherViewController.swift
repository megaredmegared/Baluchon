
import UIKit

class WeatherViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var firstCityName: UILabel!
    @IBOutlet weak var firstCityTemperature: UILabel!
    @IBOutlet weak var firstCityWeather: UILabel!
    @IBOutlet weak var secondCityName: UILabel!
    @IBOutlet weak var secondCityTemperature: UILabel!
    @IBOutlet weak var secondCityWeather: UILabel!
    @IBOutlet weak var firstCityWeatherIcon: UIImageView!
    @IBOutlet weak var secondCityWeatherIcon: UIImageView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the icon in tab bar to its true color
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
                self.getCitiesWeatherIcon(from: cityWeather, isSecondCity: false)
                
            } else {
                self.presentAlert("Today sync of weather failed")
            }
        }
    }
    
    /// get weather icon for both cities
    private func getCitiesWeatherIcon(from cityWeather: CityWeather, isSecondCity: Bool) {
        
        // get city icon name
        var cityIconName = cityWeather.list[0].weather[0].icon
        if isSecondCity {
            cityIconName = cityWeather.list[1].weather[0].icon
        }
        WeatherService.shared.getWeatherIcon(for: cityIconName) { (success, iconData) in
            if success, let iconData = iconData {
                if isSecondCity {
                    self.secondCityWeatherIcon.image = UIImage(data: iconData)
                } else {
                    self.firstCityWeatherIcon.image = UIImage(data: iconData)
                    // then get second city icon
                    self.getCitiesWeatherIcon(from: cityWeather, isSecondCity: true)
                }
            } else {
                self.presentAlert("No icon found")
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
    private func presentAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
