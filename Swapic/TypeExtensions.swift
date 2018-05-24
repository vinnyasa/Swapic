/*********************************************************************
 ** Program name: Swapic Flicker app
 ** Author: Vinny Harris-Riviello
 ** Date: April 28, 2016
 ** Description: Extensions to primitive types String and Array 
 *********************************************************************/

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        guard let url = NSURL(string: self), data = NSData(contentsOfURL: url), image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}

extension Array {
    //return an array with two arrays, first one with count of show
    func splitPhotos(show: Int) -> [[Element]] {
        let liveSplit = self[0 ..< show]
        let remainderSplit = self[show ..< self.count]
        return [Array(liveSplit), Array(remainderSplit)]
    }
    
    mutating func randomElement() -> Element {
        let index = Random(maxValue: self.count).random
        return self.removeAtIndex(index)
    }
}



