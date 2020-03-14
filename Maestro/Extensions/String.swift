//
//  String.swift
//  Maestro2
//
//  Created by David G Chopin on 3/10/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

extension String {
    func charAt(_ i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
    
    func splitEveryNCharacters(n: Int) -> [String] {
        var substrings: [String] = []
        for i in stride(from: 0, to: self.count, by: n) {
            let substring = self[i..<i+n]
            substrings.append(substring)
        }
        return substrings
    }
    
    var squareNumber: Int? {
        
        let rank: Character? = self.charAt(0)
        let file: Character? = self.charAt(1)
        
        if rank != nil && file != nil && rank!.isNumber && file!.isNumber {
            return 8 * rank!.wholeNumberValue! + file!.wholeNumberValue!
        } else {
            return nil
        }
    }
    
    func padding(leftTo paddedLength:Int, withPad pad:String=" ", startingAt padStart:Int=0) -> String {
       let rightPadded = self.padding(toLength:max(count,paddedLength), withPad:pad, startingAt:padStart)
       return "".padding(toLength:paddedLength, withPad:rightPadded, startingAt:count % paddedLength)
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
