/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: FlickrServiceTests.swift
 *********************************************************************/

import XCTest
@testable import Swapic

class FlickrServiceTests: XCTestCase {
    let flickrService = FlickrService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGalleryNil() {
        
        flickrService.getPhotos("2", key: "someKey", page: "random") { (let gallery) in
            XCTAssertNil(gallery, "Gallery should be nil with wrong params passed")
        }
    }
    func testGalleryCreated() {
        let expected = 3
        if let key = MockKeyHandler().grabKey() {
            flickrService.getPhotos(String(expected), key: key, page: "1") { (let gallery) in
                if let galleryImages = gallery {
                    XCTAssertEqual(galleryImages.images.count,  expected, "Should have 3 images")
                }
            }
        }
    }
    
    func testNetworkOperationCalled() {
        let client = MockNetworkOperation()
        flickrService.client = client
        flickrService.getPhotos("1", key: "someKey", page: "fakePageNumber") { (JsonDictionary) in
            XCTAssertTrue(client.networkOperationCalled, "Should have been called")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
   
    class MockKeyHandler: KeyHandler {
        
    }
    class MockNetworkOperation: NetworkSession {
        var networkOperationCalled = false
        let json = [String: AnyObject]()
        typealias JsonCompletion = [String: AnyObject]? -> ()
        func downloadJSONFromURL(url: NSURL, completion: JsonCompletion) {
            networkOperationCalled = true
            completion(json)
        }
    }
}
