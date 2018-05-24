/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: May 1 2016
 ** Description: Mocks for testing
 *********************************************************************/
import Foundation

enum MockJsonResponse {
    case SuccessfulJson
    case SuccessfulWithOneJsonPhoto
    case JsonPhotoWithoutTitle
    case JsonWithNilPageNilPages
    
    var  toPhotosDictionary: [String: AnyObject] {
        switch self {
        case .SuccessfulJson:
            return ["photos" : ["page" : 12, "pages" : 77, "perpage" : 3, "total" : 500, "photo" : [["id" : "26674380871", "owner" : "36994074@N04", "secret" : "f074b39765", "server" : "1606", "farm": 2, "title" : "Forlorn"],["id" : "26150180453", "owner" : "65011872@N05", "secret" : "1dcc68758a", "server" : "1581", "farm" : 2, "title" : "Sunset Kanchanaburi"],["id" : "26739227775", "owner" : "36438834@N03", "secret" : "ee69780d0c", "server" : "1674", "farm" : 2, "title" : "Amsterdam"]]], "stat" : "ok"]
        case .SuccessfulWithOneJsonPhoto:
            return ["photos" : ["page" : 12, "pages" : 144, "perpage" : 3, "total" : 500, "photo" : [["id" : "26739227775", "owner" : "36438834@N03", "secret" : "ee69780d0c", "server" : "1674", "farm" : 2, "title" : "Amsterdam"]]], "stat" : "ok"]
        case .JsonPhotoWithoutTitle:
            return ["photos" : ["page" : 12, "pages" : 167, "perpage" : 3, "total" : 500, "photo" : [["id" : "26674380871", "owner" : "36994074@N04", "secret" : "f074b39765", "server" : "1606", "farm": 2]]], "stat" : "ok"]
        case .JsonWithNilPageNilPages:
            return ["photos" : ["perpage" : 3, "total" : 500, "photo" : [["id" : "26674380871", "owner" : "36994074@N04", "secret" : "f074b39765", "server" : "1606", "farm": 2, "title" : "Forlorn"]]], "stat" : "ok"]
        }
    }
    
    func CountPhotos() -> Int? {
        let photosDictionary = self.toPhotosDictionary
        guard let photos = photosDictionary["photos"] as? [String: AnyObject], photosArray = photos["photo"] as? [[String: AnyObject]] else { return nil }
        return photosArray.count
    }
    
}
enum MockJsonFailure {
    case FailureResponse
    var toDictionary: [String: AnyObject] {
        return ["stat" : "fail", "code" : 100, "message" : "Invalid API Key (Key has invalid format)"]
    }
}
enum MockSingleJsonPhoto {
    case InitializablePhoto
    case PhotoMisingFarmProperty
    case MockPhoto
    
    var toDictionary: [String: AnyObject] {
        switch self {
        case .InitializablePhoto:
            return ["id" : "26150180453", "owner" : "65011872@N05", "secret" : "1dcc68758a", "server" : "1581", "farm" : 2, "title" : "Sunset Kanchanaburi"]
        case .PhotoMisingFarmProperty:
            return ["id": "77", "secret": "1728", "owner": "anotherPhotoFella", "server": "8", "title": "Stub Photo Title"]
        case MockPhoto:
            return ["id": "77", "secret": "1728", "owner": "somePhotographer", "server": "8", "title": "Mocked Photo", "farm": 3]
        }
    }
}
