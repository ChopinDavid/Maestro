//
//  ViewController.swift
//  Maestro
//
//  Created by David G Chopin on 3/7/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var WP: UInt64 = 0
    var WN: UInt64 = 0
    var WB: UInt64 = 0
    var WR: UInt64 = 0
    var WQ: UInt64 = 0
    var WK: UInt64 = 0
    var BP: UInt64 = 0
    var BN: UInt64 = 0
    var BB: UInt64 = 0
    var BR: UInt64 = 0
    var BQ: UInt64 = 0
    var BK: UInt64 = 0
    
    let EP: UInt64 = 0
    var CWK: Bool = false
    var CWQ: Bool = false
    var CBK: Bool = false
    var CBQ: Bool = false
    var universalCastleWhiteK: Bool = false
    var universalCastleWhiteQ: Bool = false
    var universalCastleBlackK: Bool = false
    var universalCastleBlackQ: Bool = false
    var whiteToMove: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let boardGeneration = BoardGeneration()
        boardGeneration.viewController = self
        
        
        boardGeneration.initiateStandardChess()
        //print(Moves.shared.possibleMovesW(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ))
        
        Perft.shared.perft(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ, whiteToMove: whiteToMove, depth: 0)
        print(Perft.shared.perftMoveCounter)
    }
}

