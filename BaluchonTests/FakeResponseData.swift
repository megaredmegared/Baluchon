
import Foundation
import UIKit

class FakeResponseData {
    //MARK: - Fake data common to all
    /// Fake response OK
    static let responseOK = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    /// Fake response KO
    static let responseKO = HTTPURLResponse(url: URL(string: "https://testok.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    /// Fake error
    class ExchangeRateError: Error {}
    static let error = ExchangeRateError()
    
    /// Fake data KO
    static let incorrectData = "erreur".data(using: .utf8)!
    
    //MARK: - Fake response data for ExchangeRate
    /// Fake data OK
    static var exchangeRateData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    //MARK: - Fake response data for Translation
    /// Fake data ok
    static var translationData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translation", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    //MARK: - Fake response data for CityWeather
    /// Fake data ok
    static var cityWeatherData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "CityWeather", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    /// Fake weather icon data Ok with real image
    static let iconDataOk = UIImage(named: "okImage.jpg")?.pngData()
}

