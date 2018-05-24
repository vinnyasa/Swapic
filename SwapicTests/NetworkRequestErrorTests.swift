/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: NetworkRequestErrorTests.swift
 *********************************************************************/


import XCTest
@testable import Swapic

class NetworkRequestErrorTests: XCTestCase {
    let networkErrorRawValue = "network unavailable"
    let invalidDataErrorRawValue = "invalid data"
    let invalidHTTPResponseRawValue = "invalid response"
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRawValue() {
        let networkError = NetworkRequestError.NetworkUnavailable.rawValue
        XCTAssertEqual(networkError, networkErrorRawValue)
        let invalidData = NetworkRequestError.InvalidData.rawValue
        XCTAssertEqual(invalidData, invalidDataErrorRawValue)
        let invalidHttpResponse = NetworkRequestError.InvalidHTTPResponse.rawValue
        XCTAssertEqual(invalidHttpResponse, invalidHTTPResponseRawValue)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
