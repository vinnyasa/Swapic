//
//  SwapicTableTableViewController.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/28/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import UIKit

class SwapicTableViewController: UITableViewController {
    
    var photos = [(title: String, image: UIImage)]()
    var photosSource = [(title: String, image: UIImage)]()
    var featured = 10
    let perPage = "35"
    let rowHeight = CGFloat(288)
    var page = Page(Random(maxValue: 15))
    var isInitialRequest = true
    var reloadedCells = true {
        didSet {
            photosSource.count >= photos.count / 2 ? showcasePhotos() : loadImages()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadImages()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        tableView.rowHeight = rowHeight
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! SwapicTableViewCell
        cell.photoImageView?.image = photos[indexPath.row].image
        cell.photoTitleLabel?.text = photos[indexPath.row].title
        
        return cell
    }
    
    func showcasePhotos() {
        var featured = [(String, UIImage)]()
        let half = photos.count/2
        for _ in 0..<half {
            featured.append(photosSource.randomElement())
        }
        //display photos every 10 seconds
        let delay = Double(NSEC_PER_SEC) * 10.0
        let timeDispatch = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(timeDispatch, dispatch_get_main_queue()) {
            //reload at index
            self.updateCells(featured)
        }
    }
    
    func updateCells(featured: [(String, UIImage)]) {
        let generator:RandomNumberGenerator = Random(maxValue: photos.count)
        let indexes = generator.randomise(featured.count)
        //change image for these indexes
        var indexPaths = [NSIndexPath]()
        for (i, index) in indexes.enumerate() {
            // swap photos array
            photos[index] = featured[i]
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            indexPaths.append(indexPath)
        }
        tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
        reloadedCells = true
    }
    
    func showInitialPhotos() {
        tableView.reloadData()
        isInitialRequest = false
        showcasePhotos()
    }

    
    // MARK: - Data Fetching
  
    func loadImages() {
        guard let key = grabKey() else { return }
        if isInitialRequest  {
            updatePhotos(key, page: page.number)
        } else {
            let unique = page.handleUniqueRandom()
            do {
                let uniqueRandomPage = try unique()
                updatePhotos(key, page: uniqueRandomPage)
            } catch {
                //restartPhotoGallery or let user know they have seen all photos or something.
            }
        }
    }
    
    func updatePhotos(key: String, page: String, service: RestHandler = FlickrService()) {
        let photoService = service
        photoService.getPhotos(perPage, key: key, page: page) {
            (let gallery) in
            if let galleryImages = gallery {
                var photoGallery = galleryImages.titledImages.splitPhotos(self.featured)
                //back to main - dispatch
                dispatch_async(dispatch_get_main_queue()) {
                    guard self.isInitialRequest else {
                        self.photosSource = galleryImages.titledImages
                        self.showcasePhotos()
                        return
                    }
                    self.photos = photoGallery[0]
                    self.photosSource = photoGallery[1]
                    if let pages = galleryImages.pages {
                        self.page = Page(Random(maxValue: pages))
                    }
                    self.showInitialPhotos()
                }
            } else {
                //handle error still in back thread
                //can check for Reachability here
                dispatch_async(dispatch_get_main_queue()) {
                    self.prettyCatchError(NetworkRequestError.InvalidHTTPResponse)
                }
            }
        }
    }
    
    // MARK: - Network Delegate Methods
    
    func prettyCatchError(error: ErrorType) {
        //handle invalid network response
        if let networkError = error as? NetworkRequestError {
            print("Network error occured: \(networkError.rawValue)).")
            //create AlertController 
        }
    }
}
