
@testable import Baluchon
import XCTest

class ExchangeRateServiceTestCase: XCTestCase {
    /// Testing Error
    func testGivenError_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad response
    func testGivenBadResponse_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(
            data: FakeResponseData.exchangeRateData,
            response: FakeResponseData.responseKO,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing bad data
    func testGivenBadData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing no response, no data
    func testGivenNoData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(
            data: nil,
            response: nil,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(exchangeRate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    /// Testing when everything is OK
    func testGivenAllGood_WhenPostCallBack_ThenSuccesCallBackAndData() {
        // Given
        let exchangeRateService = ExchangeRateService(session: URLSessionFake(
            data: FakeResponseData.exchangeRateData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getExchangeRate { (success, exchangeRate) in
            // Then
            let date = "2019-03-01"
            let base = "EUR"
            let rates = ["AED": 4.177475,
                         "AFN": 86.130533,
                         "ALL": 125.645712,
                         "AMD": 560.031282,
                         "ANG": 2.072676,
                         "AOA": 357.298254,
                         "ARS": 44.491108,
                         "AUD": 1.602834,
                         "AWG": 2.047654,
                         "AZN": 1.939055,
                         "BAM": 1.956219,
                         "BBD": 2.285741,
                         "BDT": 95.460107,
                         "BGN": 1.956047,
                         "BHD": 0.428693,
                         "BIF": 2059.310657,
                         "BMD": 1.137269,
                         "BND": 1.535771,
                         "BOB": 7.858817,
                         "BRL": 4.266463,
                         "BSD": 1.136985,
                         "BTC": 0.000298,
                         "BTN": 80.659169,
                         "BWP": 11.9743,
                         "BYN": 2.436998,
                         "BYR": 22290.481225,
                         "BZD": 2.301824,
                         "CAD": 1.493916,
                         "CDF": 1854.886765,
                         "CHF": 1.135217,
                         "CLF": 0.028486,
                         "CLP": 744.574259,
                         "CNY": 7.623107,
                         "COP": 3498.58201,
                         "CRC": 693.717327,
                         "CUC": 1.137269,
                         "CUP": 30.13764,
                         "CVE": 110.552257,
                         "CZK": 25.617223,
                         "DJF": 202.115244,
                         "DKK": 7.461399,
                         "DOP": 57.574218,
                         "DZD": 134.595608,
                         "EGP": 19.91477,
                         "ERN": 17.059605,
                         "ETB": 32.350772,
                         "EUR": 1,
                         "FJD": 2.416982,
                         "FKP": 0.852958,
                         "GBP": 0.857837,
                         "GEL": 3.047595,
                         "GGP": 0.857999,
                         "GHS": 6.232125,
                         "GIP": 0.852975,
                         "GMD": 56.334648,
                         "GNF": 10418.58248,
                         "GTQ": 8.810473,
                         "GYD": 238.627523,
                         "HKD": 8.925768,
                         "HNL": 27.907408,
                         "HRK": 7.429216,
                         "HTG": 95.029667,
                         "HUF": 315.842824,
                         "IDR": 16055.117147,
                         "ILS": 4.12126,
                         "IMP": 0.857999,
                         "INR": 80.659699,
                         "IQD": 1362.619392,
                         "IRR": 47884.730621,
                         "ISK": 135.710549,
                         "JEP": 0.857999,
                         "JMD": 147.164783,
                         "JOD": 0.806097,
                         "JPY": 127.168902,
                         "KES": 113.78665,
                         "KGS": 79.308504,
                         "KHR": 4580.29582,
                         "KMF": 491.876424,
                         "KPW": 1023.610233,
                         "KRW": 1279.37158,
                         "KWD": 0.345391,
                         "KYD": 0.951622,
                         "KZT": 425.70307,
                         "LAK": 9800.931602,
                         "LBP": 1717.447227,
                         "LKR": 204.469549,
                         "LRD": 183.783245,
                         "LSL": 15.910355,
                         "LTL": 3.358061,
                         "LVL": 0.687923,
                         "LYD": 1.581278,
                         "MAD": 10.870022,
                         "MDL": 19.613337,
                         "MGA": 4037.931703,
                         "MKD": 61.589913,
                         "MMK": 1718.584521,
                         "MNT": 2994.127656,
                         "MOP": 9.232807,
                         "MRO": 406.005239,
                         "MUR": 38.720042,
                         "MVR": 17.571183,
                         "MWK": 828.421562,
                         "MXN": 21.927126,
                         "MYR": 4.632952,
                         "MZN": 71.301096,
                         "NAD": 15.80533,
                         "NGN": 411.964415,
                         "NIO": 37.570852,
                         "NOK": 9.732581,
                         "NPR": 128.81285,
                         "NZD": 1.667993,
                         "OMR": 0.43777,
                         "PAB": 1.137213,
                         "PEN": 3.75714,
                         "PGK": 3.823275,
                         "PHP": 58.803086,
                         "PKR": 159.035135,
                         "PLN": 4.302518,
                         "PYG": 6971.63263,
                         "QAR": 4.141083,
                         "RON": 4.74617,
                         "RSD": 118.116165,
                         "RUB": 74.86781,
                         "RWF": 1027.250004,
                         "SAR": 4.264931,
                         "SBD": 9.296381,
                         "SCR": 15.532856,
                         "SDG": 54.379107,
                         "SEK": 10.502877,
                         "SGD": 1.537906,
                         "SHP": 1.502218,
                         "SLL": 9894.244274,
                         "SOS": 660.753693,
                         "SRD": 8.481769,
                         "STD": 23940.203846,
                         "SVC": 9.992394,
                         "SYP": 585.693549,
                         "SZL": 15.943381,
                         "THB": 36.048597,
                         "TJS": 10.774547,
                         "TMT": 3.991816,
                         "TND": 3.463383,
                         "TOP": 2.572787,
                         "TRY": 6.09316,
                         "TTD": 7.72041,
                         "TWD": 35.059707,
                         "TZS": 2666.667868,
                         "UAH": 30.566366,
                         "UGX": 4229.789444,
                         "USD": 1.137269,
                         "UYU": 37.222949,
                         "UZS": 9586.952217,
                         "VEF": 11.358478,
                         "VND": 26387.949328,
                         "VUV": 129.817335,
                         "WST": 2.957557,
                         "XAF": 656.113214,
                         "XAG": 0.073032,
                         "XAU": 0.000869,
                         "XCD": 3.073527,
                         "XDR": 0.815877,
                         "XOF": 656.125089,
                         "XPF": 119.288303,
                         "YER": 284.092645,
                         "ZAR": 16.039764,
                         "ZMK": 10236.778619,
                         "ZMW": 13.675645,
                         "ZWL": 366.604506
            ]
            
            
            XCTAssertTrue(success)
            XCTAssertNotNil(exchangeRate)
            XCTAssertEqual(date, exchangeRate!.date)
            XCTAssertEqual(base, exchangeRate!.base)
            XCTAssertEqual(rates, exchangeRate!.rates)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
