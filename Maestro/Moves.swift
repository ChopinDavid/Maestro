//
//  Moves.swift
//  Maestro2
//
//  Created by David G Chopin on 3/8/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

class Moves {
    let fileA: UInt64 = 72340172838076673
    let fileH: UInt64 = 9259542123273814144
    let filesAB: UInt64 = 217020518514230019
    let filesGH: UInt64 = 13889313184910721216
    let rank1: UInt64 = 18374686479671623680
    let rank4: UInt64 = 1095216660480
    let rank5: UInt64 = 4278190080
    let rank8: UInt64 = 255
    let center: UInt64 = 103481868288
    let extendedCenter: UInt64 = 66229406269440
    let kingSide: UInt64 = 17361641481138401520
    let queenSide: UInt64 = 1085102592571150095
    var notWhitePieces: UInt64!
    var blackPieces: UInt64!
    var empty: UInt64!
    var occupied: UInt64!
    
    let rankMasks8: [UInt64] = [ 255, 65280, 16711680, 4278190080, 1095216660480, 280375465082880, 71776119061217280, 18374686479671623680 ]
    let fileMasks8: [UInt64] = [ 72340172838076673, 144680345676153346, 289360691352306692, 578721382704613384, 1157442765409226768, 2314885530818453536, 4629771061636907072, 9259542123273814144 ]
    let diagonalMasks8: [UInt64] = [ 1, 258, 66052, 16909320, 4328785936, 1108169199648, 283691315109952, 72624976668147840, 145249953336295424, 290499906672525312, 580999813328273408, 1161999622361579520, 2323998145211531264, 4647714815446351872, 9223372036854775808 ]
    let antiDiagonalMasks8: [UInt64] = [ 128, 32832, 8405024, 2151686160, 550831656968, 141012904183812, 36099303471055874, 9241421688590303745, 4620710844295151872, 2310355422147575808, 1155177711073755136, 577588855528488960, 288794425616760832, 144396663052566528, 72057594037927936 ]
    
    func horizontalAndVerticalMoves(s: Int) -> UInt64 {
        let binaryS: UInt64 = 1<<s
        let a = occupied
        let b = occupied.byteSwapped
        let possibilitiesHorizontal: UInt64 = (occupied - 2 * binaryS) ^ (occupied.byteSwapped - 2 * binaryS.byteSwapped).byteSwapped
        let possibilitiesVertical: UInt64 = ((occupied & fileMasks8[s % 8]) - (2 * binaryS)) ^ ((occupied & fileMasks8[s % 8]).byteSwapped - (2 * binaryS.byteSwapped)).byteSwapped
        return (possibilitiesHorizontal & rankMasks8[s / 8]) | (possibilitiesVertical & fileMasks8[s % 8])
    }
    
    func diagonalAndAntiDiagonalMoves(s: Int) -> UInt64 {
        let binaryS: UInt64 = 1<<s
        let possibilitiesDiagonal: UInt64 = ((occupied & diagonalMasks8[(s / 8) + (s % 8)]) - (2 * binaryS)) ^ ((occupied & diagonalMasks8[(s / 8) + (s % 8)]).byteSwapped - (2 * binaryS.byteSwapped)).byteSwapped
        let possibilitiesAntiDiagonal = ((occupied & antiDiagonalMasks8[(s / 8) + 7 - (s % 8)]) - (2 * binaryS)) ^ ((occupied & antiDiagonalMasks8[(s / 8) + (s % 8)]).byteSwapped - (2 * binaryS.byteSwapped)).byteSwapped
        return (possibilitiesDiagonal & diagonalMasks8[(s / 8) + (s % 8)]) | (possibilitiesAntiDiagonal & antiDiagonalMasks8[(s / 8) + 7 - (s % 8)])
    }
    
    func possibleMovesW(history: String, WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64) -> String {
        notWhitePieces = ~(WP|WN|WB|WR|WQ|WK|BK)
        blackPieces = BP|BN|BB|BR|BQ
        occupied = WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK
        empty = ~occupied
        
        let list: String = possiblePW(history: history, WP: WP, BP: BP)
        
        print(horizontalAndVerticalMoves(s: 0))
        
        return list
    }
    
    func possiblePW(history: String, WP: UInt64, BP: UInt64) -> String {
        var list: String = ""
        
        //first, let's look at right-captures
        var pawnMoves: UInt64 = (WP>>7) & blackPieces & ~rank8 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8+1)\(i%8-1)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, left captures
        pawnMoves = (WP>>9) & blackPieces & ~rank8 & ~fileH
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8+1)\(i%8+1)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, moving 1 forward
        pawnMoves = (WP>>8) & empty & ~rank8
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8+1)\(i%8)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, moving 2 forward
        pawnMoves = (WP>>16) & empty & (empty>>8) & rank4
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8+2)\(i%8)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, promoting, capturing right
        pawnMoves = (WP>>7) & blackPieces & rank8 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8-1)\(i%8)QP\(i%8-1)\(i%8)RP\(i%8-1)\(i%8)BP\(i%8-1)\(i%8)NP"
                }
            }
        }
        
        //now, promoting, capturing left
        pawnMoves = (WP>>9) & blackPieces & rank8 & ~fileH
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8+1)\(i%8)QP\(i%8+1)\(i%8)RP\(i%8+1)\(i%8)BP\(i%8+1)\(i%8)NP"
                }
            }
        }
        
        //now, promoting, moving 1 forward
        pawnMoves = (WP>>8) & empty & rank8
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8)\(i%8)QP\(i%8)\(i%8)RP\(i%8)\(i%8)BP\(i%8)\(i%8)NP"
                }
            }
        }
        
        if history.count >= 4 {
            let squaresMoved = abs(Int(String(history[history.index(history.startIndex, offsetBy: history.count - 2)]))! - Int(String(history[history.index(history.startIndex, offsetBy: history.count - 4)]))!)
            if history[history.index(before: history.endIndex)] == history[history.index(history.startIndex, offsetBy: history.count - 3)] && squaresMoved == 2 {
                let eFile: Int = Int(String(history[history.index(before: history.endIndex)]))! - 0
                //en passant right
                var possibility: UInt64 = (WP << 1) & BP & rank5 & ~fileA & fileMasks8[eFile]
                if (possibility != 0) {
                    let index: Int = possibility.trailingZeroBitCount
                    list += "\(index%8-1)\(index%8) E"
                }
                //en passant left
                possibility = (WP >> 1) & BP & rank5 & ~fileH & fileMasks8[eFile]
                if (possibility != 0) {
                    let index: Int = possibility.trailingZeroBitCount
                    list += "\(index%8+1)\(index%8) E"
                }
            }
        }
        
        return list
    }
    
    func drawBitboard(bitBoard: UInt64) {
        var chessBoard: [[String]] = [
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""],
            ["","","","","","","",""]
        ]
        for i in 0..<64 {
            if ((bitBoard>>i)&1) == 1 {
                chessBoard[i/8][i%8] = "P"
            }
            if chessBoard[i/8][i%8] == "" {
                chessBoard[i/8][i%8] = " "
            }
        }
        
        for i in 0..<64 {
            print(chessBoard[i].description)
        }
    }
}
