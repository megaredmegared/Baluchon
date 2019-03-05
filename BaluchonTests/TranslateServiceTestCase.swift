//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by megared on 04/03/2019.
//  Copyright © 2019 OpenClassrooms. All rights reserved.
//

@testable import Baluchon
import XCTest

class TranslateServiceTestCase: XCTestCase {

    func testGivenError_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let translateService = TranslateService(session: URLSessionFake(
            data: nil,
            response: nil,
            error: FakeResponseData.error
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(for: "Hello, this is a test", from: "en", to: "fr") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenBadResponse_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.translationData,
            response: FakeResponseData.responseKO,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(for: "Hello, this is a test", from: "en", to: "fr") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenBadData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(for: "Hello, this is a test", from: "en", to: "fr") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenNoData_WhenPostCallBack_ThenFailedCallBack() {
        // Given
        let translateService = TranslateService(session: URLSessionFake(
            data: nil,
            response: nil,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(for: "Hello, this is a test", from: "en", to: "fr") { (success, translation) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenAllGood_WhenPostCallBack_ThenSuccesCallBackAndData() {
        // Given
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.translationData,
            response: FakeResponseData.responseOK,
            error: nil
        ))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(for: "Hello, this is a test", from: "en", to: "fr") { (success, translation) in
            // Then
            let translatedText = "Bonjour, ceci est un test"
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)
            
            XCTAssertEqual(translatedText, translation?.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
