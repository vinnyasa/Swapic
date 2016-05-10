//
//  Random.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/29/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation
import UIKit

protocol RandomNumberGenerator {
    var maxValue: Int { get set }
    var random: Int { get }
}

struct Random: RandomNumberGenerator {
    var maxValue: Int
    var random: Int {
        //maxValue is acually excluded returns a random value from half open range 0..<maxValue
        return  Int(arc4random_uniform(UInt32(maxValue)))
    }

}

