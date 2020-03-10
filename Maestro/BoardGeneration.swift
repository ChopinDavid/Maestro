//
//  BoardGeneration.swift
//  Maestro2
//
//  Created by David G Chopin on 3/7/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

class BoardGeneration {
    let EP: UInt64 = 1157442765409226768
    var CWK: Bool = false
    var CWQ: Bool = false
    var CBK: Bool = false
    var CBQ: Bool = false
    var universalCastleWhiteK: Bool = false
    var universalCastleWhiteQ: Bool = false
    var universalCastleBlackK: Bool = false
    var universalCastleBlackQ: Bool = false
    func initiateStandardChess() {
        let WP: UInt64 = 0
        let WN: UInt64 = 0
        let WB: UInt64 = 0
        let WR: UInt64 = 0
        let WQ: UInt64 = 0
        let WK: UInt64 = 0
        let BP: UInt64 = 0
        let BN: UInt64 = 0
        let BB: UInt64 = 0
        let BR: UInt64 = 0
        let BQ: UInt64 = 0
        let BK: UInt64 = 0
        
        let chessBoard: [[String]] = [
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            ["R"," "," "," ","K"," "," ","R"]
        ]
        
        arrayToBitboards(chessBoard: chessBoard, WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK)
        
    }
    
    func initiateChess960() {
        let WP: UInt64 = 0
        let WN: UInt64 = 0
        let WB: UInt64 = 0
        let WR: UInt64 = 0
        let WQ: UInt64 = 0
        let WK: UInt64 = 0
        let BP: UInt64 = 0
        let BN: UInt64 = 0
        let BB: UInt64 = 0
        let BR: UInt64 = 0
        let BQ: UInt64 = 0
        let BK: UInt64 = 0
        
        var chessBoard: [[String]] = [
            [" "," "," "," "," "," "," "," "],
            ["p","p","p","p","p","p","p","p"],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            [" "," "," "," "," "," "," "," "],
            ["P","P","P","P","P","P","P","P"],
            [" "," "," "," "," "," "," "," "]
        ]
        
        //place first bishop
        let bishop1File = Int.random(in: 0..<8)
        chessBoard[0][bishop1File] = "b"
        chessBoard[7][bishop1File] = "B"
        
        //place second bishop
        var bishop2File = Int.random(in: 0..<8)
        while bishop2File%2 == bishop1File%2 {
            bishop2File = Int.random(in: 0..<8)
        }
        chessBoard[0][bishop2File] = "b"
        chessBoard[7][bishop2File] = "B"
        
        //place queen
        var queenFile = Int.random(in: 0..<8)
        while queenFile == bishop2File || queenFile == bishop1File {
            queenFile = Int.random(in: 0..<8)
        }
        chessBoard[0][queenFile] = "q"
        chessBoard[7][queenFile] = "Q"
        
        //place the first knight
        let knight1file = Int.random(in: 0..<5)
        var counter: Int = 0
        var loop: Int = 0
        while counter - 1 < knight1file {
            if chessBoard[0][loop] == " " {
                counter += 1
            }
            loop += 1
        }
        chessBoard[0][loop - 1] = "n"
        chessBoard[7][loop - 1] = "N"
        
        //place the second knight
        let knight2file = Int.random(in: 0..<4)
        counter = 0
        loop = 0
        while counter - 1 < knight2file {
            if chessBoard[0][loop] == " " {
                counter += 1
            }
            loop += 1
        }
        chessBoard[0][loop - 1] = "n"
        chessBoard[7][loop - 1] = "N"
        
        //place first remaining rook
        counter = 0
        while chessBoard[0][counter] != " " {
            counter += 1
        }
        chessBoard[0][counter] = "r"
        chessBoard[7][counter] = "R"
        
        //place king
        while chessBoard[0][counter] != " " {
            counter += 1
        }
        chessBoard[0][counter] = "k"
        chessBoard[7][counter] = "K"
        
        //place last remaining rook
        while chessBoard[0][counter] != " " {
            counter += 1
        }
        chessBoard[0][counter] = "r"
        chessBoard[7][counter] = "R"
        
        arrayToBitboards(chessBoard: chessBoard, WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK)
    }
    
    func arrayToBitboards(chessBoard: [[String]], WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64) {
        var WP = WP
        var WN = WN
        var WB = WB
        var WR = WR
        var WQ = WQ
        var WK = WK
        var BP = BP
        var BN = BN
        var BB = BB
        var BR = BR
        var BQ = BQ
        var BK = BK
        var binary: String!
        
        for i in 0..<64 {
            binary = "0000000000000000000000000000000000000000000000000000000000000000"
            binary = binary!.suffix(from: binary!.index(binary!.startIndex, offsetBy: i+1)) + "1" + binary!.prefix(upTo: binary!.index(binary!.startIndex, offsetBy: i))
            
            switch chessBoard[i/8][i%8] {
            case "P":
                WP += convertStringToBitboard(binary)
            case "N":
                WN += convertStringToBitboard(binary)
            case "B":
                WB += convertStringToBitboard(binary)
            case "R":
                WR += convertStringToBitboard(binary)
            case "Q":
                WQ += convertStringToBitboard(binary)
            case "K":
                WK += convertStringToBitboard(binary)
            case "p":
                BP += convertStringToBitboard(binary)
            case "n":
                BN += convertStringToBitboard(binary)
            case "b":
                BB += convertStringToBitboard(binary)
            case "r":
                BR += convertStringToBitboard(binary)
            case "q":
                BQ += convertStringToBitboard(binary)
            case "k":
                BK += convertStringToBitboard(binary)
            default:
                break
            }
        }
        
        drawArray(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK)
        
        Moves().possibleMovesW(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ)
        
    }
    
    func convertStringToBitboard(_ binary: String) -> UInt64 {
        if binary.prefix(1) == "0" {
            //A positive number
            return UInt64(binary, radix: 2)!
        } else {
            //A negative number
            return UInt64("1"+binary.suffix(from: binary.index(binary.startIndex, offsetBy: 2)), radix: 2)! * 2
        }
    }
    
    func drawArray(WP: UInt64, WN: UInt64, WB: UInt64, WR: UInt64, WQ: UInt64, WK: UInt64, BP: UInt64, BN: UInt64, BB: UInt64, BR: UInt64, BQ: UInt64, BK: UInt64) {
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
            chessBoard[i/8][i%8] = " "
        }
        for i in 0..<64 {
            if (((WP>>i)&1)==1) { chessBoard[i/8][i%8] = "P" }
            if (((WN>>i)&1)==1) { chessBoard[i/8][i%8] = "N" }
            if (((WB>>i)&1)==1) { chessBoard[i/8][i%8] = "B" }
            if (((WR>>i)&1)==1) { chessBoard[i/8][i%8] = "R" }
            if (((WQ>>i)&1)==1) { chessBoard[i/8][i%8] = "Q" }
            if (((WK>>i)&1)==1) { chessBoard[i/8][i%8] = "K" }
            
            if (((BP>>i)&1)==1) { chessBoard[i/8][i%8] = "p" }
            if (((BN>>i)&1)==1) { chessBoard[i/8][i%8] = "n" }
            if (((BB>>i)&1)==1) { chessBoard[i/8][i%8] = "b" }
            if (((BR>>i)&1)==1) { chessBoard[i/8][i%8] = "r" }
            if (((BQ>>i)&1)==1) { chessBoard[i/8][i%8] = "q" }
            if (((BK>>i)&1)==1) { chessBoard[i/8][i%8] = "k" }
        }
        
        for rank in chessBoard {
            print(rank.description)
        }
    }
}

