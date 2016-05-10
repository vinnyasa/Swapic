//
//  SwapicTableViewControllerTests.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 5/2/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import XCTest
import UIKit
@testable import Swapic

class SwapicTableViewControllerTests: XCTestCase {
    var tableViewController: SwapicTableViewController?
    override func setUp() {
        super.setUp()
        
        tableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SwapicTableViewController") as? SwapicTableViewController
        tableViewController?.performSelectorOnMainThread(#selector(tableViewController?.viewDidLoad), withObject: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: loading method tests

    
    func testTableViewController() {
        XCTAssertNotNil(tableViewController)
    }
    
    func testViewDidLoad() {
        XCTAssertNotNil(tableViewController, "View should initiate properly");
    }
    
    func testTableViewExists() {
        XCTAssertNotNil(tableViewController?.tableView, "Controller should have a tableView")
        
    }
    
    //MARK: properties
    
    func testDataSource() {
        XCTAssertNotNil(tableViewController?.isInitialRequest)
        guard let isInitial = tableViewController?.isInitialRequest else { XCTFail(); return }
        XCTAssertTrue(isInitial)
        
    }
    //MARK: tableView tests
    
    func testNumberOFSections() {
        if let tableView = tableViewController?.tableView, sections = tableViewController?.numberOfSectionsInTableView(tableView) {
            XCTAssertEqual(sections, 1)
        }
    }
    
    func testNumberOfRowsInSection() {
        let expected = tableViewController?.photos.count
        XCTAssertEqual(tableViewController?.tableView?.numberOfRowsInSection(0), expected)
    }
    
    func testTableViewCellReusableIdentifier() {
        // test without photos mock
        if tableViewController?.photos.count > 0 {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cell = tableViewController?.tableView?.cellForRowAtIndexPath(indexPath)
            let expected = "photoCell"
            let actual = cell?.reuseIdentifier ?? ""
            XCTAssertEqual(actual, expected, "cell should have \(expected) identifier")
        }
        //need to test with mock also
    }
    
    func testNewCells() {
        let featured = tableViewController?.featured
        print("Photos count on test \(tableViewController?.photos.count)")
        XCTAssertTrue(featured == 10, "Photos should be loaded already")
    
    }
    
    func testUpdateCells() {
        let mockFeaturedPhotos = MockFeaturedPhotos.MockJsonPhotos
        tableViewController?.photos = mockFeaturedPhotos.toMockPhotos()
        if let newPhoto = mockFeaturedPhotos.toMockPhoto(MockSingleJsonPhoto.InitializablePhoto.toDictionary), photos = tableViewController?.photos {
            tableViewController?.updateCells([(newPhoto.title, newPhoto.image)])
            let titles =  photos.map{ $0.title }
            let newPhotoLoaded = titles.contains(newPhoto.title)
            XCTAssertTrue(newPhotoLoaded, "New photo should have been added to photos")
        }
    }
    
    func testUpdatePhotos() {
        let mockService = MockFlickrService()
        tableViewController?.updatePhotos("someKey", page: "fake8", service: mockService)
        XCTAssert(mockService.getPhotosCalled)
    }
    
    
    func testExtensionGrabKeyNil() {
        XCTAssertNil(MockHandler().keyNil, "Should be nil with empty path as argument")
    }
    
    class MockHandler: KeyHandler {
        
        var keyNil: String? {
            return grabKey("")
        }
    }
    
    enum MockFeaturedPhotos {
        case MockJsonPhotos
        
        var toJsonArray: [[String: AnyObject]] {
            return [["id" : "26674380871", "owner" : "36994074@N04", "secret" : "f074b39765", "server" : "1606", "farm": 2, "title" : "Forlorn"],["id" : "26150180453", "owner" : "65011872@N05", "secret" : "1dcc68758a", "server" : "1581", "farm" : 2, "title" : "Sunset Kanchanaburi"],["id" : "26739227775", "owner" : "36438834@N03", "secret" : "ee69780d0c", "server" : "1674", "farm" : 2, "title" : "Amsterdam"]]
        }
        
        func toMockPhotos() -> [(title: String, image: UIImage)] {
            var mockPhotos = [(title: String, image: UIImage)]()
            let jsonPhotosArray = self.toJsonArray
            for mock in jsonPhotosArray {
                if let photo = toMockPhoto(mock) {
                    mockPhotos.append(photo)
                }
            }
            return mockPhotos
        }
        
        func toMockPhoto(mockPhoto: [String: AnyObject]) -> (title: String, image: UIImage)? {
            guard let photo = Photo(photoDictionary: mockPhoto), let image = photo.imageSource?.toImage() else  { return nil }
            return (title: photo.title, image: image)
        }
    }
    
    class MockFlickrService: RestHandler {
        let featured = 2
        var getPhotosCalled = false
        let json: [String: AnyObject] = MockJsonResponse.SuccessfulJson.toPhotosDictionary
        
        var gallery: Gallery? { return Gallery(jsonDictionary: json) }
        
        func getPhotos(perPage: String, key: String, page: String, completion: (Gallery?) -> Void  )  {
            getPhotosCalled = true
            guard let galleryCompletion = gallery else { completion(nil); return }
            completion(galleryCompletion)
        }
    }
    
}
