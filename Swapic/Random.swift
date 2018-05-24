/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 29, 2016
 ** Description: Helper to handle random photos. 
 *********************************************************************/

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

