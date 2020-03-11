//
//  Perft.swift
//  Maestro2
//
//  Created by David G Chopin on 3/10/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

class Perft {
    
    static var shared: Perft = Perft()
    func moveToAlgebra(move: String) -> String {
        var moveString: String = ""
        moveString += "\(move.charAt(1).wholeNumberValue! + 49)"
        moveString += "\(8 - move.charAt(0).wholeNumberValue!)"
        moveString += "\(move.charAt(3).wholeNumberValue! + 49)"
        moveString += "\(8 - move.charAt(2).wholeNumberValue!)"
        return moveString
    }
    
    //static int perftTotalMoveCounter=0;
    var perftMoveCounter: Int = 0
    var perftMaxDepth: Int = 6
    func perft(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64, EP: UInt64, CWK: Bool, CWQ: Bool, CBK: Bool, CBQ: Bool, whiteToMove: Bool, depth: Int) {
        if depth < perftMaxDepth {
            var moves: String!
            if whiteToMove {
                moves = Moves.shared.possibleMovesW(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ)
            } else {
                moves = Moves.shared.possibleMovesB(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ)
            }
            
            for i in stride(from: 0, to: moves.count, by: 4) {
                let WPt: UInt64 = Moves.shared.makeMove(board: WP, move: moves[i..<i+4], type: "P")
                let WNt: UInt64 = Moves.shared.makeMove(board: WN, move: moves[i..<i+4], type: "N")
                let WBt: UInt64 = Moves.shared.makeMove(board: WB, move: moves[i..<i+4], type: "B")
                let WRt: UInt64 = Moves.shared.makeMove(board: WR, move: moves[i..<i+4], type: "R")
                let WQt: UInt64 = Moves.shared.makeMove(board: WQ, move: moves[i..<i+4], type: "Q")
                let WKt: UInt64 = Moves.shared.makeMove(board: WK, move: moves[i..<i+4], type: "K")
                let BPt: UInt64 = Moves.shared.makeMove(board: BP, move: moves[i..<i+4], type: "p")
                let BNt: UInt64 = Moves.shared.makeMove(board: BN, move: moves[i..<i+4], type: "n")
                let BBt: UInt64 = Moves.shared.makeMove(board: BB, move: moves[i..<i+4], type: "b")
                let BRt: UInt64 = Moves.shared.makeMove(board: BR, move: moves[i..<i+4], type: "r")
                let BQt: UInt64 = Moves.shared.makeMove(board: BQ, move: moves[i..<i+4], type: "q")
                let BKt: UInt64 = Moves.shared.makeMove(board: BK, move: moves[i..<i+4], type: "k")
                let EPt: UInt64 = Moves.shared.makeMoveEP(board: WP|BP, move: moves[i..<i+4])
                var CWKt: Bool = CWK
                var CWQt: Bool = CWQ
                var CBKt: Bool = CBK
                var CBQt: Bool = CBQ
                if moves.charAt(3).isNumber {
                    let start: Int = (moves.charAt(i).wholeNumberValue! * 8) + (moves.charAt(i + 1).wholeNumberValue!)
                    if ((1<<start) & WK) != 0 {
                        CWKt = false
                        CWQt = false
                    }
                    if ((1<<start) & BK) != 0 {
                        CBKt = false
                        CBQt = false
                    }
                    if ((1<<start) & WR & (1<<63)) != 0 {
                        CWKt = false
                    }
                    if ((1<<start) & WR & (1<<56)) != 0 {
                        CWQt = false
                    }
                    if ((1<<start) & BR & (1<<7)) != 0 {
                        CBKt = false
                    }
                    if ((1<<start) & BR & 1) != 0 {
                        CBQt = false
                    }
                }
                if ((WKt & Moves.shared.unsafeForWhite(WP: WPt, WN: WNt, WB: WBt, WR: WRt, WQ: WQt, WK: WKt, BP: BPt, BN: BNt, BB: BBt, BR: BRt, BQ: BQt, BK: BKt)) == 0 && whiteToMove) || ((BKt & Moves.shared.unsafeForBlack(WP: WPt, WN: WNt, WB: WBt, WR: WRt, WQ: WQt, WK: WKt, BP: BPt, BN: BNt, BB: BBt, BR: BRt, BQ: BQt, BK: BKt)) == 0 && !whiteToMove) {
                    if depth + 1 == perftMaxDepth {
                        perftMoveCounter += 1
                    }
                    perft(WP: WPt, WN: WNt, WB: WBt, WR: WRt, WQ: WQt, WK: WKt, BP: BPt, BN: BNt, BB: BBt, BR: BRt, BQ: BQt, BK: BKt, EP: EPt, CWK: CWKt, CWQ: CWQt, CBK: CBKt, CBQ: CBQt, whiteToMove: !whiteToMove, depth: depth+1)
                }
            }
        }
    }
}
