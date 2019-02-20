//
//  Change.swift
//  Baluchon
//
//  Created by megared on 18/02/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class ExchangeRateService {
    private static let url = URL(string: "http://data.fixer.io/api/latest?access_key=2b1c586fe6418b1ca758d811c6593b1f&base=EUR")! // Try to get away with the optional
 
    static func getChange() {
    var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data) else {
                return
            }
         
        }
            
        task.resume()
        
    }
}
