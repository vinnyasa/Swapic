/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: GalleryTests.swift
 *********************************************************************/


import XCTest
@testable import Swapic

class PhotoTests: XCTestCase {
    let photoDictionary: [String: AnyObject] = MockSingleJsonPhoto.MockPhoto.toDictionary
    let expectedImageSource = "https://farm3.static.flickr.com/8/77_1728_c.jpg"
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotosInit() {
        
        let farm = photoDictionary["farm"] as? Int ?? 0
        let expected = String(farm)
        if let photo = Photo(photoDictionary: photoDictionary) {
            XCTAssertEqual(photo.farm,  expected)
            XCTAssertEqual(photo.imageSource, expectedImageSource)
        }
    }
    
    func testPhotosProperties() {
        let farm = photoDictionary["farm"] as? Int ?? 0
        let expectedFarm = String(farm)
        let expectedId = photoDictionary["id"] as? String ?? ""
        let expectedSecret = photoDictionary["secret"] as? String ?? ""
        let expectedServer = photoDictionary["server"] as? String ?? ""
        if let photo = Photo(photoDictionary: photoDictionary) {
            XCTAssertEqual(photo.farm, expectedFarm, "farm property should be what we assigned")
            XCTAssertEqual(photo.id, expectedId, "id should be what we assigned")
            XCTAssertEqual(photo.secret, expectedSecret, "secret should be what we assigned")
            XCTAssertEqual(photo.server, expectedServer, "server should be what we assigned")
            XCTAssertNotNil(photo.owner, "optional owner should be present")
            XCTAssertNotNil(photo.title, "optional title should be present")
            XCTAssertEqual(photo.imageSource, expectedImageSource)
        }
    }
    
    func testPhotosImageSource() {
        if let photo = Photo(photoDictionary: photoDictionary) {
            XCTAssertNotNil(photo.imageSource)
        }
    }
    
    func testPhotoImageSourceNil() {
        if let photo = Photo(photoDictionary: photoDictionary) {
            var samePhoto = photo
            samePhoto.size = nil
            XCTAssertNil(samePhoto.imageSource)
        }
    
    }
    
    // MARK: Independent Photo Tests - need their own object
    func testPhotosFailableInit() {
        
        let photoDictionary: [String: AnyObject] = MockSingleJsonPhoto.PhotoMisingFarmProperty.toDictionary
            XCTAssertNil(Photo(photoDictionary: photoDictionary), "photo object init without nonOptional properties should be nil")
    }
    
    func testPhotosNoImageSource() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let photoDictionary: [String: AnyObject] = MockSingleJsonPhoto.InitializablePhoto.toDictionary
        if var photo = Photo(photoDictionary: photoDictionary) {
            photo.size = nil
            XCTAssertNil(photo.imageSource)
        } else { XCTFail("Can't test wthout a photo instance") }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
