//
//  Weather.swift

/// City weather infos
struct CityWeather: Codable {
    let list: [City]
    
    struct City: Codable {
        
        let main: Main
        let name: String
        let weather: [Weather]
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        
        struct Main: Codable {
            let temp: Double
        }
    }
}
