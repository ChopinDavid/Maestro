//
//  FixedWidthInteger.swift
//  Maestro2
//
//  Created by David G Chopin on 3/11/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension FixedWidthInteger {
    var bitSwapped: Self {
        var v = self
        var s = Self(v.bitWidth)
        precondition(s.nonzeroBitCount == 1, "Bit width must be a power of two")
        var mask = ~Self(0)
        repeat  {
            s = s >> 1
            mask ^= mask << s
            v = ((v >> s) & mask) | ((v << s) & ~mask)
        } while s > 1
        return v
    }
}
