//
//  Page.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 5/1/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation

protocol Randomisable {
    var generator: RandomNumberGenerator { get set }
}


struct Page: Randomisable {
    let number: String
    var generator: RandomNumberGenerator
    
    init(_ generator: RandomNumberGenerator) {
        self.generator = generator
        number = generator.randomString
    }
}

