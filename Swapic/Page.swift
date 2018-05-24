/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 28, 2016
 ** Description: struct Page helps select photos from different pages. 
 *********************************************************************/

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

