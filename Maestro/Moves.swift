//
//  Moves.swift
//  Maestro
//
//  Created by David G Chopin on 3/8/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

class Moves {
    static var shared: Moves = Moves()
    
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
    let kingSpan: UInt64 = 460039
    let knightSpan: UInt64 = 43234889994
    var notMyPieces: UInt64!
    var myPieces: UInt64!
    var empty: UInt64!
    var occupied: UInt64!
    
    let castleRooks: [UInt64] = [ 63, 56, 7, 0 ]
    let rankMasks8: [UInt64] = [ 255, 65280, 16711680, 4278190080, 1095216660480, 280375465082880, 71776119061217280, 18374686479671623680 ]
    let fileMasks8: [UInt64] = [ 72340172838076673, 144680345676153346, 289360691352306692, 578721382704613384, 1157442765409226768, 2314885530818453536, 4629771061636907072, 9259542123273814144 ]
    let diagonalMasks8: [UInt64] = [ 1, 258, 66052, 16909320, 4328785936, 1108169199648, 283691315109952, 72624976668147840, 145249953336295424, 290499906672525312, 580999813328273408, 1161999622361579520, 2323998145211531264, 4647714815446351872, 9223372036854775808 ]
    let antiDiagonalMasks8: [UInt64] = [ 128, 32832, 8405024, 2151686160, 550831656968, 141012904183812, 36099303471055874, 9241421688590303745, 4620710844295151872, 2310355422147575808, 1155177711073755136, 577588855528488960, 288794425616760832, 144396663052566528, 72057594037927936 ]
    
    func horizontalAndVerticalMoves(s: Int) -> UInt64 {
        let binaryS: UInt64 = 1<<s
        let possibilitiesHorizontal: UInt64 = (occupied &- (2 &* binaryS)) ^ UInt64.reverse(UInt64.reverse(occupied) &- 2 &* UInt64.reverse(binaryS))
        let possibilitiesVertical: UInt64 = ((occupied & fileMasks8[s % 8]) &- (2 &* binaryS)) ^ UInt64.reverse(UInt64.reverse(occupied & fileMasks8[s % 8]) &- (2 &* UInt64.reverse(binaryS)))
        return (possibilitiesHorizontal & rankMasks8[s / 8]) | (possibilitiesVertical & fileMasks8[s % 8])
        
        /*
        let rankMask: UInt64 = rankMasks8[s/8]
        let fileMask: UInt64 = fileMasks8[s%8]
        let pseudoPossibleMoves: UInt64 = rankMask ^ fileMask
        var unblockedRanks: UInt64 = 0
        var unblockedFiles: UInt64 = 0
        var direction: Direction! = Direction.north
        
        var testingSquare: Int = s - 8
        while direction == .north {
            if testingSquare < 0 || testingSquare%8 != s%8 {
                direction = .east
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedRanks += rankMasks8[testingSquare/8]
                    direction = .east
                } else {
                    unblockedRanks += rankMasks8[testingSquare/8]
                    testingSquare -= 8
                }
            }
        }
        
        testingSquare = s + 1
        while direction == .east {
            if testingSquare > 63 || testingSquare/8 != s/8 {
                direction = .south
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedFiles += fileMasks8[testingSquare%8]
                    direction = .south
                } else {
                    unblockedFiles += fileMasks8[testingSquare%8]
                    testingSquare += 1
                }
            }
        }
        
        testingSquare = s + 8
        while direction == .south {
            if testingSquare > 63 || testingSquare%8 != s%8 {
                direction = .west
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedRanks += rankMasks8[testingSquare/8]
                    direction = .west
                } else {
                    unblockedRanks += rankMasks8[testingSquare/8]
                    testingSquare += 8
                }
            }
        }
        
        testingSquare = s - 1
        while direction == .west {
            if testingSquare < 0 || testingSquare/8 != s/8 {
                direction = .north
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedFiles += fileMasks8[testingSquare%8]
                    direction = .north
                } else {
                    unblockedFiles += fileMasks8[testingSquare%8]
                    testingSquare -= 1
                }
            }
        }
        
        let mask = unblockedRanks | unblockedFiles
        let possibleMoves = pseudoPossibleMoves&mask
        
        return possibleMoves*/
    }
    
    func diagonalAndAntiDiagonalMoves(s: Int) -> UInt64 {
        let binaryS: UInt64 = 1<<s
        let possibilitiesDiagonal: UInt64 = ((occupied & diagonalMasks8[(s / 8) &+ (s % 8)]) &- (2 &* binaryS)) ^ UInt64.reverse(UInt64.reverse(occupied & diagonalMasks8[(s / 8) &+ (s % 8)]) &- (2 &* UInt64.reverse(binaryS)))
        let possibilitiesAntiDiagonal: UInt64 = ((occupied & antiDiagonalMasks8[(s / 8) &+ 7 &- (s % 8)]) &- (2 &* binaryS)) ^ UInt64.reverse(UInt64.reverse(occupied & antiDiagonalMasks8[(s / 8) &+ 7 &- (s % 8)]) &- (2 &* UInt64.reverse(binaryS)))
        return (possibilitiesDiagonal & diagonalMasks8[(s / 8) &+ (s % 8)]) | (possibilitiesAntiDiagonal & antiDiagonalMasks8[(s / 8) &+ 7 &- (s % 8)])
        
        /*
        let diagonalMask: UInt64! = diagonalMasks8[s%8 + s/8]
        let antiDiagonalMask: UInt64! = antiDiagonalMasks8[(7 - s%8) + s/8]
        let pseudoPossibleMoves: UInt64 = diagonalMask ^ antiDiagonalMask
        var unblockedDiagonals: UInt64 = 0
        var unblockedAntiDiagonals: UInt64 = 0
        var direction: Direction! = Direction.northeast
        
        var testingSquare: Int = s - 7
        while direction == .northeast {
            if testingSquare < 0 || testingSquare > 63 || testingSquare/8 == s/8 {
                direction = .southeast
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedAntiDiagonals += antiDiagonalMasks8[(7 - testingSquare%8) + testingSquare/8]
                    direction = .southeast
                } else {
                    unblockedAntiDiagonals += antiDiagonalMasks8[(7 - testingSquare%8) + testingSquare/8]
                    testingSquare -= 7
                }
            }
        }
        
        testingSquare = s + 9
        while direction == .southeast {
            if testingSquare > 63 || testingSquare/8 == s/8 {
                direction = .southwest
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedDiagonals += diagonalMasks8[testingSquare%8 + testingSquare/8]
                    direction = .southwest
                } else {
                    unblockedDiagonals += diagonalMasks8[testingSquare%8 + testingSquare/8]
                    testingSquare += 9
                }
            }
        }
        
        testingSquare = s + 7
        while direction == .southwest {
            if testingSquare < 0 || testingSquare > 63 || testingSquare%8 == s%8 {
                direction = .northwest
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedAntiDiagonals += antiDiagonalMasks8[(7 - testingSquare%8) + testingSquare/8]
                    direction = .northwest
                } else {
                    unblockedAntiDiagonals += antiDiagonalMasks8[(7 - testingSquare%8) + testingSquare/8]
                    testingSquare += 7
                }
            }
        }
        
        testingSquare = s - 9
        while direction == .northwest {
            if testingSquare < 0 || testingSquare/8 == s/8 {
                direction = .northeast
            } else {
                if 1<<testingSquare&occupied != 0 {
                    unblockedDiagonals += diagonalMasks8[testingSquare%8 + testingSquare/8]
                    direction = .northeast
                } else {
                    unblockedDiagonals += diagonalMasks8[testingSquare%8 + testingSquare/8]
                    testingSquare -= 9
                }
            }
        }
        
        let mask = unblockedDiagonals | unblockedAntiDiagonals
        let possibleMoves = pseudoPossibleMoves&mask
        
        return possibleMoves*/
    }
    
    func makeMove(board: UInt64, move: String, type: Character) -> UInt64 {
        var board = board
        if move.charAt(3).isNumber {//'regular' move
            let start: UInt64 = UInt64((move.charAt(0).wholeNumberValue!*8)+(move.charAt(1).wholeNumberValue!))
            let end: UInt64 = UInt64((move.charAt(2).wholeNumberValue!*8)+(move.charAt(3).wholeNumberValue!))
            if ((board>>start)&1) == 1 {
                board &= ~(1<<start)
                board |= (1<<end)
            } else {
                board &= ~(1<<end)
            }
        } else if (move.charAt(3) == "P") {//pawn promotion
            var start: UInt64!
            var end: UInt64!
            if move.charAt(2).isUppercase {
                start = UInt64((fileMasks8[move.charAt(0).wholeNumberValue!] & rankMasks8[1]).trailingZeroBitCount)
                end = UInt64((fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[0]).trailingZeroBitCount)
            } else {
                start = UInt64((fileMasks8[move.charAt(0).wholeNumberValue!] & rankMasks8[6]).trailingZeroBitCount)
                end = UInt64((fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[7]).trailingZeroBitCount)
            }
            if type == move.charAt(2) {
                board &= ~(1<<start)
                board |= (1<<end)
            } else {
                board &= ~(1<<end)
            }
        } else if move.charAt(3)=="E" {//en passant
            var start: UInt64!
            var end: UInt64!
            if move.charAt(2).isUppercase {
                start = UInt64((fileMasks8[move.charAt(0).wholeNumberValue!] & rankMasks8[4]).trailingZeroBitCount)
                end = UInt64((fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[5]).trailingZeroBitCount)
                board &= ~(1<<(fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[4]))
            } else {
                start = UInt64((fileMasks8[move.charAt(0).wholeNumberValue!] & rankMasks8[3]).trailingZeroBitCount)
                end = UInt64((fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[2]).trailingZeroBitCount)
                board &= ~(1<<(fileMasks8[move.charAt(1).wholeNumberValue!] & rankMasks8[3]))
            }
            if ((board>>start)&1)==1 {
                board &= ~(1<<start)
                board |= (1<<end)
            }
        } else {
            print("ERROR: Invalid move type")
        }
        return board
    }
    
    func makeMoveEP(board: UInt64, move: String) -> UInt64 {
        if move.charAt(3).isNumber {
            let start: Int = (move.charAt(0).wholeNumberValue! * 8) + move.charAt(1).wholeNumberValue!
            if (abs(move.charAt(0).wholeNumberValue! - move.charAt(2).wholeNumberValue!) == 2) && (((board>>start) & 1) == 1) {//pawn double push
                return fileMasks8[move.charAt(1).wholeNumberValue!]
            }
        }
        return 0
    }
    
    func possibleMovesW(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64, EP: UInt64, CWK: Bool, CWQ: Bool, CBK: Bool, CBQ: Bool) -> String {
        notMyPieces = ~(WP|WN|WB|WR|WQ|WK|BK)
        myPieces = WP|WN|WB|WR|WQ
        occupied = WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK
        empty = ~occupied
        
        let list: String = "\(possibleWP(WP: WP, BP: BP, EP: EP))\(possibleN(occupied: occupied, N: WN))\(possibleB(occupied: occupied, B: WB))\(possibleR(occupied: occupied, R: WR))\(possibleQ(occupied: occupied, Q: WQ))\(possibleK(occupied: occupied, K: WK))\(possibleCW(WR: WR, CWK: CWK, CWQ: CWQ))"
        return list
    }
    
    func possibleMovesB(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64, EP: UInt64, CWK: Bool, CWQ: Bool, CBK: Bool, CBQ: Bool) -> String {
        notMyPieces = ~(BP|BN|BB|BR|BQ|BK|WK)
        myPieces = BP|BN|BB|BR|BQ
        occupied = WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK
        empty = ~occupied
        
        let list: String = "\(possibleBP(BP: BP, WP: WP, EP: EP))\(possibleN(occupied: occupied, N: BN))\(possibleB(occupied: occupied, B: BB))\(possibleR(occupied: occupied, R: BR))\(possibleQ(occupied: occupied, Q: BQ))\(possibleK(occupied: occupied, K: BK))\(possibleCB(BR: BR, CBK: CBK, CBQ: CBQ))"
        return list
    }
    
    func possibleWP(WP: UInt64, BP: UInt64, EP: UInt64) -> String {
        var list: String = ""
        var possibility: UInt64!
        
        //first, let's look at right-captures
        let opponentPieces = occupied & ~myPieces
        var pawnMoves: UInt64 = (WP>>7) & opponentPieces & ~rank8 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8+1)\(i%8-1)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, left captures
        pawnMoves = (WP>>9) & opponentPieces & ~rank8 & ~fileH
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
        pawnMoves = (WP>>7) & occupied & ~myPieces & rank8 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8-1)\(i%8)QP\(i%8-1)\(i%8)RP\(i%8-1)\(i%8)BP\(i%8-1)\(i%8)NP"
                }
            }
        }
        
        //now, promoting, capturing left
        pawnMoves = (WP>>9) & occupied & ~myPieces & rank8 & ~fileH
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
        
        possibility = (WP << 1) & BP & rank5 & ~fileA & EP
        if possibility != 0 {
            let index: Int = possibility.trailingZeroBitCount
            list += "\(index%8-1)\(index%8) E"
        }
        
        possibility = (WP >> 1) & BP & rank5 & ~fileH & EP
        if possibility != 0 {
            let index: Int = possibility.trailingZeroBitCount
            list += "\(index%8+1)\(index%8) E"
        }
        
        return list
    }
    
    func possibleBP(BP: UInt64, WP: UInt64, EP: UInt64) -> String {
        var list: String = ""
        var possibility: UInt64!
        
        //first, let's look at right-captures
        let opponentPieces = occupied & ~myPieces
        var pawnMoves: UInt64 = (BP<<7) & opponentPieces & ~rank1 & ~fileH
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8-1)\(i%8+1)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, left captures
        pawnMoves = (BP<<9) & opponentPieces & ~rank1 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8-1)\(i%8-1)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, moving 1 forward
        pawnMoves = (BP<<8) & empty & ~rank1
        
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8-1)\(i%8)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, moving 2 forward
        pawnMoves = (BP<<16) & empty & (empty<<8) & rank5
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i/8-2)\(i%8)\(i/8)\(i%8)"
                }
            }
        }
        
        //now, promoting, capturing right
        pawnMoves = (BP<<7) & occupied & ~myPieces & rank1 & ~fileH
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8+1)\(i%8)QP\(i%8+1)\(i%8)RP\(i%8+1)\(i%8)BP\(i%8+1)\(i%8)NP"
                }
            }
        }
        
        //now, promoting, capturing left
        pawnMoves = (BP<<9) & occupied & ~myPieces & rank1 & ~fileA
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8-1)\(i%8)QP\(i%8-1)\(i%8)RP\(i%8-1)\(i%8)BP\(i%8-1)\(i%8)NP"
                }
            }
        }
        
        //now, promoting, moving 1 forward
        pawnMoves = (BP<<8) & empty & rank1
        if pawnMoves != 0 {
            for i in pawnMoves.trailingZeroBitCount..<64 - pawnMoves.leadingZeroBitCount {
                if ((pawnMoves>>i)&1) == 1 {
                    list += "\(i%8)\(i%8)QP\(i%8)\(i%8)RP\(i%8)\(i%8)BP\(i%8)\(i%8)NP"
                }
            }
        }
        
        possibility = (BP >> 1) & WP & rank4 & ~fileH & EP
        if possibility != 0 {
            let index: Int = possibility.trailingZeroBitCount
            list += "\(index%8+1)\(index%8) E"
        }
        
        possibility = (BP << 1) & WP & rank4 & ~fileA & EP
        if possibility != 0 {
            let index: Int = possibility.trailingZeroBitCount
            list += "\(index%8-1)\(index%8) E"
        }
        return list
    }
    
    func possibleN(occupied: UInt64, N: UInt64) -> String {
        var N = N
        var list: String = ""
        if N != 0 {
            var i: UInt64 = N & ~(N-1)
            var possibility: UInt64!
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                if iLocation > 18 {
                    possibility = knightSpan<<(iLocation-18)
                } else {
                    possibility = knightSpan>>(18-iLocation)
                }
                
                if iLocation%8 < 4 {
                    possibility &= ~filesGH&notMyPieces
                } else {
                    possibility &= ~filesAB&notMyPieces
                }
                if possibility != 0 {
                    var j: UInt64 = possibility & ~(possibility - 1)
                    while j != 0 {
                        let index: Int = j.trailingZeroBitCount
                        list += "\(iLocation/8)\(iLocation%8)\(index/8)\(index%8)"
                        possibility &= ~j
                        
                        if possibility != 0 {
                            j = possibility & ~(possibility-1)
                        } else {
                            j = 0
                        }
                    }
                    N &= ~i
                    if N != 0 {
                        i = N & ~(N - 1)
                    } else {
                        i = 0
                    }
                } else {
                    i = 0
                }
            }
        }
        return list
    }
    
    func possibleB(occupied: UInt64, B: UInt64) -> String {
        var B = B
        var list: String = ""
        if B != 0 {
            var i: UInt64 = B & ~(B - 1)
            var possibility: UInt64!
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = diagonalAndAntiDiagonalMoves(s: iLocation)&notMyPieces
                if possibility != 0 {
                    var j: UInt64 = possibility & ~(possibility - 1)
                    while j != 0 {
                        let index: Int = j.trailingZeroBitCount
                        list += "\(iLocation/8)\(iLocation%8)\(index/8)\(index%8)"
                        possibility &= ~j
                        if possibility != 0 {
                            j = possibility & ~(possibility - 1)
                        } else {
                            j = 0
                        }
                    }
                    B &= ~i
                    if B != 0 {
                        i = B & ~(B - 1)
                    } else {
                        i = 0
                    }
                } else {
                    i = 0
                }
            }
        }
        return list
    }
    
    func possibleR(occupied: UInt64, R: UInt64) -> String {
        var R = R
        var list: String = ""
        if R != 0 {
            var i: UInt64 = R & ~(R - 1)
            var possibility: UInt64!
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = horizontalAndVerticalMoves(s: iLocation)&notMyPieces
                if possibility != 0 {
                    var j: UInt64 = possibility & ~(possibility - 1)
                    while j != 0 {
                        let index: Int = j.trailingZeroBitCount
                        list += "\(iLocation/8)\(iLocation%8)\(index/8)\(index%8)"
                        possibility &= ~j
                        if possibility != 0 {
                            j = possibility & ~(possibility - 1)
                        } else {
                            j = 0
                        }
                    }
                    R &= ~i
                    if R != 0 {
                        i = R & ~(R - 1)
                    } else {
                        i = 0
                    }
                } else {
                    i = 0
                }
            }
        }
        return list
    }
    
    func possibleQ(occupied: UInt64, Q: UInt64) -> String {
        var Q = Q
        var list: String = ""
        if Q != 0 {
            var i: UInt64 = Q & ~(Q - 1)
            var possibility: UInt64!
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = (horizontalAndVerticalMoves(s: iLocation)|diagonalAndAntiDiagonalMoves(s: iLocation))&notMyPieces
                if possibility != 0 {
                    var j: UInt64 = possibility & ~(possibility - 1)
                    while j != 0 {
                        let index: Int = j.trailingZeroBitCount
                        list += "\(iLocation/8)\(iLocation%8)\(index/8)\(index%8)"
                        possibility &= ~j
                        if possibility != 0 {
                            j = possibility & ~(possibility - 1)
                        } else {
                            j = 0
                        }
                    }
                    Q &= ~i
                    if Q != 0 {
                        i = Q & ~(Q - 1)
                    } else {
                        i = 0
                    }
                } else {
                    i = 0
                }
            }
        }
        return list
    }
    
    func possibleK(occupied: UInt64, K: UInt64) -> String {
        var list: String = ""
        var possibility: UInt64!
        let iLocation: Int = K.trailingZeroBitCount
        if iLocation > 9 {
            possibility = kingSpan<<(iLocation - 9)
        } else {
            possibility = kingSpan>>(9 - iLocation)
        }
        
        if iLocation%8 < 4 {
            possibility &= ~filesGH&notMyPieces
        } else {
            possibility &= ~filesAB&notMyPieces
        }
        
        if possibility != 0 {
            var j: UInt64 = possibility & ~(possibility - 1)
            
            while (j != 0) {
                let index: Int = j.trailingZeroBitCount
                list += "\(iLocation/8)\(iLocation%8)\(index/8)\(index%8)"
                possibility &= ~j
                if possibility != 0 {
                    j = possibility & ~(possibility - 1)
                } else {
                    j = 0
                }
            }
        }
        return list
    }
    
    func possibleCW(WR: UInt64, CWK: Bool, CWQ: Bool) -> String {
        var list: String = ""
        if CWK && (((1<<castleRooks[0]) & WR) != 0) {
            list += "7476"
        }
        
        if CWQ && (((1<<castleRooks[1]) & WR) != 0) {
            list += "7472";
        }
        return list
    }
    
    func possibleCB(BR: UInt64, CBK: Bool, CBQ: Bool) -> String {
        var list: String = ""
        if CBK && (((1<<castleRooks[2]) & BR) != 0) {
            list += "0406";
        }
        if CBQ && (((1<<castleRooks[3])&BR) != 0) {
            list += "0402";
        }
        return list
    }
    
    func unsafeForWhite(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64) -> UInt64 {
        var BN: UInt64 = BN
        var unsafe: UInt64!
        occupied = WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK
        //pawn
        unsafe = (BP<<7) & ~fileH//pawn capture right
        unsafe |= (BP<<9) & ~fileA//pawn capture left
        
        var possibility: UInt64!
        //knight
        var i: UInt64!
        if BN != 0 {
            i = BN & ~(BN-1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                if iLocation > 18 {
                    possibility = knightSpan<<(iLocation - 18)
                } else {
                    possibility = knightSpan>>(18 - iLocation)
                }
                
                if iLocation%8 < 4 {
                    possibility &= ~filesGH
                } else {
                    possibility &= ~filesAB
                }
                
                unsafe |= possibility
                BN &= ~i
                if BN != 0 {
                    i = BN & ~(BN-1)
                } else {
                    i = 0
                }
            }
        }
        
        //bishop/queen
        var QB: UInt64 = BQ|BB
        if QB != 0 {
            i = QB & ~(QB - 1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = diagonalAndAntiDiagonalMoves(s: iLocation)
                unsafe |= possibility
                QB &= ~i
                if QB != 0 {
                    i = QB & ~(QB-1)
                } else {
                    i = 0
                }
            }
        }
        
        //rook/queen
        var QR: UInt64 = BQ|BR
        if QR != 0 {
            i = QR & ~(QR - 1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = horizontalAndVerticalMoves(s: iLocation)
                unsafe |= possibility
                QR &= ~i
                if QR != 0 {
                    i = QR & ~(QR-1)
                } else {
                    i = 0
                }
            }
        }
        
        //king
        let iLocation: Int = BK.trailingZeroBitCount
        if iLocation > 9 {
            possibility = kingSpan<<(iLocation - 9)
        } else {
            possibility = kingSpan>>(9 - iLocation)
        }
        if iLocation%8 < 4 {
            possibility &= ~filesGH
        } else {
            possibility &= ~filesAB
        }
        unsafe |= possibility
        
        return unsafe
    }
    
    func unsafeForBlack(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64) -> UInt64 {
        var WN: UInt64 = WN
        var unsafe: UInt64!
        occupied = WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK
        //pawn
        unsafe = (WP>>7) & ~fileA //pawn capture right
        unsafe |= (WP>>9) & ~fileH //pawn capture left
        
        var possibility: UInt64!
        //knight
        var i: UInt64!
        if WN != 0 {
            i = WN & ~(WN-1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                if iLocation > 18 {
                    possibility = knightSpan<<(iLocation - 18)
                } else {
                    possibility = knightSpan>>(18 - iLocation)
                }
                
                if iLocation%8 < 4 {
                    possibility &= ~filesGH
                } else {
                    possibility &= ~filesAB
                }
                
                unsafe |= possibility
                WN &= ~i
                if WN != 0 {
                    i = WN & ~(WN-1)
                } else {
                    i = 0
                }
            }
        }
        
        //bishop/queen
        var QB: UInt64 = WQ|WB
        
        if QB != 0 {
            i = QB & ~(QB - 1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = diagonalAndAntiDiagonalMoves(s: iLocation)
                unsafe |= possibility
                QB &= ~i
                if QB != 0 {
                    i = QB & ~(QB-1)
                } else {
                    i = 0
                }
            }
        }
        
        //rook/queen
        var QR: UInt64 = WQ|WR
        if QR != 0 {
            i = QR & ~(QR - 1)
            while i != 0 {
                let iLocation: Int = i.trailingZeroBitCount
                possibility = horizontalAndVerticalMoves(s: iLocation)
                unsafe |= possibility
                QR &= ~i
                if QR != 0 {
                    i = QR & ~(QR-1)
                } else {
                    i = 0
                }
            }
        }
        
        //king
        let iLocation: Int = WK.trailingZeroBitCount
        if iLocation > 9 {
            possibility = kingSpan<<(iLocation - 9)
        } else {
            possibility = kingSpan>>(9 - iLocation)
        }
        if iLocation%8 < 4 {
            possibility &= ~filesGH
        } else {
            possibility &= ~filesAB
        }
        unsafe |= possibility
        
        return unsafe
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

enum Direction {
    case north, northeast, east, southeast, south, southwest, west, northwest
}
