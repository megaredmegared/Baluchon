//
//  Weather.swift
//  Baluchon
//
//  Created by megared on 25/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

/// City weather infos
struct CityWeather: Codable {
    let list: [City]
    
    struct City: Codable {
        
        let main: Main
        let name: String
        let weather: [Weather]
        
        struct Weather: Codable {
            let description: String
        }
        
        struct Main: Codable {
            let temp: Double
        }
    }
}
