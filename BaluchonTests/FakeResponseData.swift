//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by megared on 01/03/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

import Foundation

class FakeResponseData {
    /// Fake response OK
    static let responseOK = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    /// Fake response KO
    static let responseKO = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    //MARK: - Fake response data for ExchangeRate
    /// Fake error
    class ExchangeRateError: Error {}
    static let error = ExchangeRateError()
    
    /// Fake data OK
    static var exchangeRateData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    /// Fake data KO
    static let incorrectData = "erreur".data(using: .utf8)!
}

