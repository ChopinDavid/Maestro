//
//  Int.swift
//  Maestro2
//
//  Created by David G Chopin on 3/13/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension Int {
    var squareId: String {
        let row: Int = self/8
        let file: Int = self%8
        return "\(row)\(file)"
    }
    
    var alphabeticalValue: Character? {
        switch self {
            case 0:
                return "a"
            case 1:
                return "b"
            case 2:
                return "c"
            case 3:
                return "d"
            case 4:
                return "e"
            case 5:
                return "f"
            case 6:
                return "g"
            case 7:
                return "h"
            default:
                return nil
        }
    }
}
