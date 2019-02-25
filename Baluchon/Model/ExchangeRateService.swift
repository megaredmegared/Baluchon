//
//  Change.swift
//  Baluchon
//
//  Created by megared on 18/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class ExchangeRateService {
    // creation of url need paid version of Fixer API for HTTPS. So "App Transport Security Settings" in Info.plist is modified to allow insecure connection on fixer.io url
    private static let url = URL(string: "http://data.fixer.io/api/latest?access_key=2b1c586fe6418b1ca758d811c6593b1f&base=EUR")!
 
    static func getExchangeRate() {

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(ExchangeRate.self, from: data) else {
                return
            }
  
            print("""





""")
            print(responseJSON.success)
            print(responseJSON.timestamp)
            print(responseJSON.base)
            print(responseJSON.date)
            print(responseJSON.rates["USD"]!)
        }
            
        task.resume()
        
    }
}
