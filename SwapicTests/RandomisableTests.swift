/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: RandomisableTests.swift
 //
 *********************************************************************/


import XCTest
@testable import Swapic

class RandomisableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHandleUniqueRandomCreatesRandom() {
        let randomPage = Page(Random(maxValue: 8))
        let createUniqueRandom = randomPage.handleUniqueRandom()
        do {
            let uniqueRandom = try createUniqueRandom()
            XCTAssertLessThan(Int(uniqueRandom)!, randomPage.generator.maxValue)
        } catch {
            XCTFail()
        }
    }
    
    func testHandleUniqueRandomThrows() {
        let expected = 3
        //create own object
        let randomPage = Page(Random(maxValue: expected))
        let createUniqueRandom = randomPage.handleUniqueRandom()
        var uniquesSet = Set<String>()
        for _ in 0..<randomPage.generator.maxValue {
            do {
                let uniqueRandom = try createUniqueRandom()
                uniquesSet.insert(uniqueRandom)
            } catch {
                XCTFail()
            }
        }
        XCTAssertEqual(uniquesSet.count, expected, "set should have 3 elements, sets have no repeated values")
        //closure should have emptied the array so next call should throw
        XCTAssertThrowsError(try createUniqueRandom())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
