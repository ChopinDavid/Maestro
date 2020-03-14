//
//  Character.swift
//  Maestro2
//
//  Created by David G Chopin on 3/11/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension Character {
    var alphabeticalToIntVal: Int? {
        switch self.lowercased() {
        case "a":
            return 0
        case "b":
            return 1
        case "c":
            return 2
        case "d":
            return 3
        case "e":
            return 4
        case "f":
            return 5
        case "g":
            return 6
        case "h":
            return 7
        default:
            return nil
        }
    }
    
    var intToAlphabeticalValue: Character? {
        return self.wholeNumberValue?.alphabeticalValue
    }
}
