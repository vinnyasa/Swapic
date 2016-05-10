//
//  SwapicTVCExtension.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/28/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

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




