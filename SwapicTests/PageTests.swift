/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: PageTests.swift
 *********************************************************************/


import XCTest
@testable import Swapic

class PageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
        
    func testRandomPage() {
        let expected = 8
        let page = Page(Random(maxValue: expected))
        XCTAssert(Int(page.number) < expected)
        let anotherPage = Page(Random(maxValue: 1))
        XCTAssert(Int(anotherPage.number) == 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
