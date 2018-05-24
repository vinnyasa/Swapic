/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: NetworkOperationTests.swift
 *********************************************************************/


import XCTest
import UIKit
@testable import Swapic

class NetworkOperationTests: XCTestCase  {
    
    private let url = MockSession.init(urlString: "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList").url
    let urlString = "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList"
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: network dependancy
    func testNetworOperationInit() {
        let networkOperation = NetworkOperation()
        XCTAssertNotNil(networkOperation, "network operation should be instantiated with url")
    }
    
    //MARK: test jsonDictionary
    
    func testDownloadJSONFromURL(){
        let mockHandler = MockKeyHandler(urlString: "\(urlString)&api_key=")
        if let url = mockHandler.urlWithKey {
            let networkOperation = NetworkOperation()
            let expectation = expectationWithDescription("wait for \(url)")
            var json: [String: AnyObject]?
            networkOperation.downloadJSONFromURL(url) { (let jsonDictionary) in
                json = jsonDictionary
                expectation.fulfill()
            }
            waitForExpectationsWithTimeout(8, handler: nil)
            XCTAssertNotNil(json)
            guard let jsonDictionary = json, status = jsonDictionary["stat"] as? String else {
                XCTFail()
                return
            }
            XCTAssertTrue(status == "ok")
        }
    }
    
    func testDownloadJSONFail() {
        if let sessionUrl = url {
            let client = NetworkOperation()
            let expectation = expectationWithDescription("wait for \(sessionUrl)")
            var json: [String: AnyObject]?
            client.downloadJSONFromURL(sessionUrl) { (let jsonDictionary) in
                json = jsonDictionary
                expectation.fulfill()
            }
            waitForExpectationsWithTimeout(5, handler: nil)
            guard let jsonDictionary = json, status = jsonDictionary["stat"] as? String else {
                return
            }
            XCTAssertTrue(status == "fail")
        }
    }
    
    //MARK: test error
     func testDataTaskErrorResponse() {
        if let sessionUrl = MockSession(urlString: "https://api.flickr.com/services/resty").url {
            let expectation = expectationWithDescription("wait for \(sessionUrl)")
            let networkOperation = NetworkOperation()
            var json: [String: AnyObject]?
            networkOperation.downloadJSONFromURL(sessionUrl) { (let jsonDictionary) in
                json = jsonDictionary
                expectation.fulfill()
            }
            waitForExpectationsWithTimeout(8, handler: nil)
            XCTAssertNil(json)
        }
     }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    class MockKeyHandler: NetworkOperationTests.MockSession, KeyHandler {
        //private let urlString: String
        let perPage = 3
        private var urlWithKey: NSURL? {
            guard let key = grabKey() else { return nil }
            return NSURL(string: "\(urlString)\(key)&per_page=\(perPage)&format=json&nojsoncallback=1")
        }
        override init(urlString: String) {
            super.init(urlString: urlString)
        }
    }
    
    class MockSession {
        private let urlString: String
        private var url: NSURL? { return NSURL(string: urlString)}
        init(urlString: String) {
        self.urlString = urlString
        }
    }
}
