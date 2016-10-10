//
//  RandomNumberGenerator.swift
//  Swapic
//
//  Created by Ahyathreah Effi-yah on 4/30/16.
//  Copyright © 2016 TrhUArrayLUV. All rights reserved.
//

import Foundation

extension RandomNumberGenerator {
    var randomString: String {
        return String(random)
    }
    
    //returns a set of random numbers
    func randomise(count : Int) -> Set<Int> {
        //creating a set so we don't have repeated indexes
        var randoms = Set<Int>()
        while randoms.count < count && count > 0 {
            let random = self.random
            randoms.insert(random)
        }
        return randoms
    }
    var sequenceArray: [Int] {
        var values = [Int]()
        for i in 0..<maxValue {
            values.append(i)
        }
        return values
    }
}

extension Randomisable {
    func handleUniqueRandom() -> () throws -> String {
        var uniquesUnused = [Int]()
        var uniquesStatus: UniquesArrayStatus = .Empty
        
        func makeUnusedUniquesArray() throws -> String {
            switch uniquesStatus {
            case .Empty:
                uniquesUnused = generator.sequenceArray
                uniquesStatus = .Built
                fallthrough
            case .Built:
                guard !uniquesUnused.isEmpty else {
                    throw GalleryError.UsedAllPhotos
                }
                let unique = uniquesUnused.randomElement()
                return String(unique)
            }
        }
        return makeUnusedUniquesArray
    }
}

enum UniquesArrayStatus {
    case Empty
    case Built
}