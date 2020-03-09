//
//  UInt64.swift
//  Maestro2
//
//  Created by David G Chopin on 3/8/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension UInt64 {
    static func reversed(_ i: UInt64) -> UInt64 {
        var binary = String(i, radix: 2)
        for _ in 0..<64-binary.count {
            binary = "0\(binary)"
        }
        
        let reversedBinary = String(binary.reversed())
        let reversedInt = UInt64(reversedBinary, radix: 2)!
        return reversedInt
    }
}
