//
//  Photo.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/28/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation

import UIKit

struct Photo {
    let id: String
    let secret: String
    let owner: String?
    let server: String
    let title: String
    let farm: String
    
    var size = PhotoSize(rawValue: "c")
    
    var imageSource: String? {
        guard let photoSize = size else { return nil }
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret)_\(photoSize.rawValue).jpg"
    }
    
    init?(photoDictionary: [String: AnyObject]) {
        //unless I have imageSource we have no image in such case fail init
        guard let farm = photoDictionary["farm"] as? Int, server = photoDictionary["server"] as? String, id = photoDictionary["id"] as? String, secret = photoDictionary["secret"] as? String, title = photoDictionary["title"] as? String  else {
            return nil
        }
        self.id = id
        self.secret = secret
        self.server = server
        self.farm = String(farm)
        self.title = title
        owner = photoDictionary["owner"] as? String ?? nil
    }
        
}


