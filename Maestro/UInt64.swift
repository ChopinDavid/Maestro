//
//  UInt64.swift
//  Maestro
//
//  Created by David G Chopin on 3/8/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension UInt64 {
    static func reverse(_ i: UInt64) -> UInt64 {
        var binary = String(i, radix: 2)
        for _ in 0..<64-binary.count {
            binary = "0\(binary)"
        }
        
        let reversedBinary: String = String(binary.reversed())
        let reversedInt: UInt64 = UInt64(reversedBinary, radix: 2)!
        return reversedInt
    }
}



extension Int {
    static func reverse(_ i: Int) -> Int {
        var negative = false
        var binary = String(i, radix: 2)
        if binary.contains("-") {
            binary.removeAll(where: { $0 == "-" })
            negative = true
        }
        for _ in 0..<64-binary.count {
            binary = "0\(binary)"
        }
        
        var reversedBinary = String(binary.reversed())
        if negative {
            reversedBinary = "-\(reversedBinary)"
        }
        let reversedInt = Int(reversedBinary, radix: 2)!
        return reversedInt
    }
}
