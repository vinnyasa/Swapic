/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 28, 2016
 ** Description: SwapicTVCExtension.swift
 *********************************************************************/


import Foundation

protocol KeyHandler {
    func grabKey(path: String?) -> String?
}


extension SwapicTableViewController: KeyHandler {
    
}

extension KeyHandler {
    func grabKey(path: String? = NSBundle.mainBundle().pathForResource("Keys", ofType: "plist")) -> String? {
        guard let pathString = path, keys = NSDictionary(contentsOfFile: pathString), let key = keys["key"] as? String else { return nil }
        return key
    }
}




