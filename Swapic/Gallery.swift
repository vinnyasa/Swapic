/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 28, 2016
 ** Description: Struct Photo represents a gallery of photos.
 *********************************************************************/

import Foundation
import UIKit

struct Gallery {
    
    var images = [UIImage]()
    var titledImages = [(title: String, image: UIImage)]()
    var photos = [(title: String, source: String)]()
    let pages: Int?
    let page: Int?
    
    
    init?(jsonDictionary: [String: AnyObject]?) {
        
        guard let json = jsonDictionary, photosDictionary = json["photos"], photosArray = photosDictionary["photo"] as? [[String: AnyObject]] else {
            return nil
        }
        pages = photosDictionary["pages"] as? Int
        page = photosDictionary["page"] as? Int
        for image in photosArray {
            let photo = Photo(photoDictionary: image)
            
            if let imageSource = photo?.imageSource, photoImage = imageSource.toImage(), title = photo?.title {
                images.append(photoImage)
                titledImages.append((title, photoImage))
                photos.append((title, imageSource))
            }
        }
    }
}

enum GalleryError: ErrorType {
    case UsedAllPhotos
    case InvalidData
}

