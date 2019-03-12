
import Foundation
import UIKit

/// Weather service from openweathermap.org API
class WeatherService {
    /// singleton instance shared
    static var shared = WeatherService()
    private init() {}
    
    //MARK: - Gather weather infos from openweathermap.org API
    /// Create one url for NewYork id=5128638 and Lyon id=6454573
    private let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128638,6454573&APPID=9af6ca5e641ba4fd6375a3359c966809&lang=fr&units=metric")!
    
    /// Create session
    private var weatherSession = URLSession(configuration: .default)
    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    private var task: URLSessionTask?
    
    /// Get weathers infos from openweathermap.org API
    func getWeather(callback: @escaping (Bool, CityWeather?) -> Void) {
        /// Stop task
        task?.cancel()
        /// Create task
        task = weatherSession.dataTask(with: url) { (data, response, error) in
            // Back in the main queue
            DispatchQueue.main.async {
                // Checks if data received
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }
                // Check if response is ok
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                // Check if data is Decodable
                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(CityWeather.self, from: data) else {
                    return callback(false, nil)
                }
                // Callback success
                callback(true, weather)
            }
        }
        /// Launch task
        task?.resume()
    }
    
    //MARK: - Get icon infos from openweathermap.org
    /// Create session
    private var weatherIconSession = URLSession(configuration: .default)
    init(weatherIconSession: URLSession) {
        self.weatherIconSession = weatherIconSession
    }
    
    /// Get weathers icon from openweathermap.org
    func getWeatherIcon(for icon: String, callback: @escaping (Bool, Data?) -> Void) {
        /// Create url for icon
        let urlIcon = URL(string: "https://openweathermap.org/img/w/\(icon).png")!

        /// Stop task
        task?.cancel()
        /// Create task
        task = weatherIconSession.dataTask(with: urlIcon) { (data, response, error) in
            // Back in the main queue
            DispatchQueue.main.async {
                // Checks if data received
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }
                // Check if response is ok
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }
                // Check if data is an image
                guard UIImage(data: data) != nil else {
                    callback(false, nil)
                    return
                }
                // Callback success
                callback(true, data)
            }
        }
        /// Launch task
        task?.resume()
    }
}
