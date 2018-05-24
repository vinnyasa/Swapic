/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: TypeExtensionsTests.swift
 *********************************************************************/

import XCTest
@testable import Swapic

class TypeExtensionsTests: XCTestCase {
    var someArray = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSplitPhotos() {
        var splitArray = someArray.splitPhotos(3)
        XCTAssertTrue(splitArray[0].count == 3)
        let splitLast = splitArray[1].popLast() ?? 0
        XCTAssertTrue(splitLast == 8)
        XCTAssertTrue(splitArray[1][1] == 4)
    }
    
    func testRemoveRandomFromArray() {
        let anotherArray = someArray
        let index = someArray.randomElement()
        XCTAssertEqual(index, anotherArray[index])
        XCTAssertFalse(someArray.contains(index))
        
    }
    
    //MARK: network dependancy
    func testToImage() {
        let urlString = "https://farm2.static.flickr.com/1672/26146814804_c57c483579_q.jpg"
        XCTAssertNotNil(urlString.toImage())
        
    }
    func testNoToImage() {
        let urlString = "https://"
        XCTAssertNil(urlString.toImage())
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
