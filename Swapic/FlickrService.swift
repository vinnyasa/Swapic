//
//  FlickrService.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/28/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation
protocol RestHandler{
    func getPhotos(perPage: String, key: String, page: String, completion: (Gallery?) -> ())
}

class FlickrService: RestHandler {
    
    private let baseURL:NSURL? = NSURL(string: "https://api.flickr.com/services/rest/")
    let format:String = "json"
    lazy var client: NetworkSession = NetworkOperation()
    
    func getPhotos(perPage: String, key: String, page: String, completion: (Gallery?) -> Void ) {
        let path = "?method=flickr.interestingness.getList&api_key=\(key)&page=\(page)&per_page=\(perPage)&format=\(format)&nojsoncallback=1"
        if let url = NSURL(string: path, relativeToURL: baseURL) {
            let networkOperation = client
            networkOperation.downloadJSONFromURL(url) {
                (let JSONDictionary) in
                completion(Gallery(jsonDictionary: JSONDictionary))
            }
        }
    }
}

enum NetworkRequestError: ErrorType {
    case InvalidHTTPResponse
    case NetworkUnavailable
    case InvalidData
    
    var rawValue: String {
        switch self {
        case .InvalidHTTPResponse:
            return "invalid response"
        case .NetworkUnavailable:
            return "network unavailable"
        case .InvalidData:
            return "invalid data"
        }
    }
}


