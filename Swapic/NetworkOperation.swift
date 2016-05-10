//
//  NetworkOperation.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/28/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation


protocol NetworkSession {
    func downloadJSONFromURL(url: NSURL, completion: [String: AnyObject]? -> ())
}

class NetworkOperation: NetworkSession {
    
    lazy var session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    //private let url: NSURL
    
    typealias JSONDictionaryCompletion = [String: AnyObject]? -> ()
    
    func downloadJSONFromURL(url: NSURL, completion: JSONDictionaryCompletion) {
        let request = NSURLRequest(URL: url)
        let dataTask = session.dataTaskWithRequest(request) {(let data, let response, let error) in
            guard let httpResponse = response as? NSHTTPURLResponse where  200...299 ~= httpResponse.statusCode else {
                completion(nil)
                return
            }
            let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
            //Flicker's failure comes as a response: json["stat"] == "fail"
            guard let jsonDictionary = json, status = jsonDictionary?["stat"] as? String where status == "ok" else { completion(nil)
                return
            }
            completion(jsonDictionary)
        }
        dataTask.resume()
    }
    
}

