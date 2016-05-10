//
//  RandomTests.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 5/2/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import XCTest
@testable import Swapic
class RandomTests: XCTestCase {
    let generator = Random(maxValue: 12)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: Bundle Random Tests
    
    func testRandom() {
        XCTAssertLessThan(generator.random, generator.maxValue, "The ramdom value should be less than max value.")
    }
    
    
    func testRandomise() {
        let count = 3
        let randomSet = generator.randomise(count)
        XCTAssertEqual(randomSet.count, count, "Random set should have \(count) elements.")
        
    }
    
    //MARK: Independent Random Tests - need their own object
    
    func testRandomString() {
        let generator = Random(maxValue: 1)
        let random = generator.random
        XCTAssertEqual(String(random), generator.randomString)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
