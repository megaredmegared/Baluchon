
@testable import Baluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    //MARK: - Testing for weahter infos
    /// Testing Error
    func testGivenError_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, cityWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityWeather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad response
    func testGivenBadResponse_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.cityWeatherData,
            response: FakeResponseData.responseKO,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, cityWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityWeather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad data
    func testGivenBadData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, cityWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityWeather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing no response, no data
    func testGivenNoData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, cityWeather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityWeather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing when everything is OK
    func testGivenAllGood_WhenPostCallBack_ThenSuccesCallBackAndData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(
            data: FakeResponseData.cityWeatherData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, cityWeather) in
            // Then
            let tempFirstCity = -10.33
            let nameFirstCity = "New York"
            let weatherFirstCity = "ciel dégagé"
            let tempSecondCity = 9.83
            let nameSecondCity = "Lyon"
            let weatherSecondCity = "couvert"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(cityWeather)
            XCTAssertEqual(tempFirstCity, cityWeather!.list[0].main.temp)
            XCTAssertEqual(nameFirstCity, cityWeather!.list[0].name)
            XCTAssertEqual(weatherFirstCity, cityWeather!.list[0].weather[0].description)
            XCTAssertEqual(tempSecondCity, cityWeather!.list[1].main.temp)
            XCTAssertEqual(nameSecondCity, cityWeather!.list[1].name)
            XCTAssertEqual(weatherSecondCity, cityWeather!.list[1].weather[0].description)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    //MARK: - Testing for icon image
    /// Testing Error
    func testGetWeatherIconGivenError_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherIconSession: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherIcon(for: "test") { (success, icon) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad response
    func testGetWeatherIconGivenBadResponse_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherIconSession: URLSessionFake(
            data: FakeResponseData.iconDataOk,
            response: FakeResponseData.responseKO,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherIcon(for: "test") { (success, icon) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad data
    func testGetWeatherIconGivenBadData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherIconSession: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherIcon(for: "test") { (success, icon) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing no response, no data
    func testGetWeatherIconGivenNoData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let weatherService = WeatherService(weatherIconSession: URLSessionFake(
            data: nil,
            response: nil,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherIcon(for: "test") { (success, icon) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing when everything is OK
    func testGetWeatherIconGivenAllGood_WhenPostCallBack_ThenSuccesCallBackAndData() {
        // Given
        let weatherService = WeatherService(weatherIconSession: URLSessionFake(
            data: FakeResponseData.iconDataOk,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeatherIcon(for: "test") { (success, icon) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(icon)
            
            let iconDataOk = UIImage(named: "okImage.jpg")?.pngData()
            
            XCTAssertEqual(iconDataOk, icon)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
