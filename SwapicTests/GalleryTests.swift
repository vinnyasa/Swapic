/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1, 2016
 ** Description: GalleryTests.swift
 *********************************************************************/


import XCTest
import UIKit
@testable import Swapic

class GalleryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGalleryFailableInit() {
        let jsonDictionary: [String: AnyObject]? = nil
        XCTAssertNil(Gallery(jsonDictionary: jsonDictionary))
    }
    
    func testGalleryPagesValue() {
        let mockSuccesfulResponse = MockJsonResponse.SuccessfulJson.toPhotosDictionary
        if let gallery = Gallery(jsonDictionary: mockSuccesfulResponse), pages = gallery.pages, pagesFromJson = mockSuccesfulResponse["photos"]?["pages"] {
            XCTAssertEqual(pages, pagesFromJson, "Pages Value should be 77")
        }
    }
    
    //MARK: caveats - network has not been mocked, using actual images
    
    func testToString() {
        if let photo = Photo(photoDictionary: MockSingleJsonPhoto.InitializablePhoto.toDictionary), imageSource = photo.imageSource {
            XCTAssertNotNil(imageSource.toImage(), "Should be image")
        } else { XCTFail("Failed to create photo object")}
    }
    
    func testGallery() {
        let mockSuccesfulResponse = MockJsonResponse.SuccessfulJson
        let expectedCount = mockSuccesfulResponse.CountPhotos() ?? 0
        if let gallery = Gallery(jsonDictionary: mockSuccesfulResponse.toPhotosDictionary) {
            XCTAssertEqual(gallery.images.count, expectedCount, "Should be \(expectedCount) gallery objects")
        }
    }
    
    func testGalleryPhotoWithoutTitle() {
        let mockPhotoWithoutTitleResponse = MockJsonResponse.JsonPhotoWithoutTitle
        let expectedCount = mockPhotoWithoutTitleResponse.CountPhotos() ?? 0
        if let gallery = Gallery(jsonDictionary: mockPhotoWithoutTitleResponse.toPhotosDictionary) {
            XCTAssertFalse(gallery.images.count == expectedCount)
            XCTAssertFalse(gallery.titledImages.count == expectedCount)
        }
    }
    
    
    
    func  testGalleryPagesNil()  {
        let mockResponseWithNilPageNilPages = MockJsonResponse.JsonWithNilPageNilPages
        let expected = mockResponseWithNilPageNilPages.CountPhotos() ?? 0
        if let gallery = Gallery(jsonDictionary: mockResponseWithNilPageNilPages.toPhotosDictionary) {
            XCTAssertEqual(gallery.images.count,  expected)
            XCTAssertNil(gallery.pages)
            
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

