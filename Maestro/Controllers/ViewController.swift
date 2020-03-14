//
//  ViewController.swift
//  Maestro
//
//  Created by David G Chopin on 3/7/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var b0: UIButton!
    @IBOutlet var b1: UIButton!
    @IBOutlet var b2: UIButton!
    @IBOutlet var b3: UIButton!
    @IBOutlet var b4: UIButton!
    @IBOutlet var b5: UIButton!
    @IBOutlet var b6: UIButton!
    @IBOutlet var b7: UIButton!
    @IBOutlet var b8: UIButton!
    @IBOutlet var b9: UIButton!
    @IBOutlet var b10: UIButton!
    @IBOutlet var b11: UIButton!
    @IBOutlet var b12: UIButton!
    @IBOutlet var b13: UIButton!
    @IBOutlet var b14: UIButton!
    @IBOutlet var b15: UIButton!
    @IBOutlet var b16: UIButton!
    @IBOutlet var b17: UIButton!
    @IBOutlet var b18: UIButton!
    @IBOutlet var b19: UIButton!
    @IBOutlet var b20: UIButton!
    @IBOutlet var b21: UIButton!
    @IBOutlet var b22: UIButton!
    @IBOutlet var b23: UIButton!
    @IBOutlet var b24: UIButton!
    @IBOutlet var b25: UIButton!
    @IBOutlet var b26: UIButton!
    @IBOutlet var b27: UIButton!
    @IBOutlet var b28: UIButton!
    @IBOutlet var b29: UIButton!
    @IBOutlet var b30: UIButton!
    @IBOutlet var b31: UIButton!
    @IBOutlet var b32: UIButton!
    @IBOutlet var b33: UIButton!
    @IBOutlet var b34: UIButton!
    @IBOutlet var b35: UIButton!
    @IBOutlet var b36: UIButton!
    @IBOutlet var b37: UIButton!
    @IBOutlet var b38: UIButton!
    @IBOutlet var b39: UIButton!
    @IBOutlet var b40: UIButton!
    @IBOutlet var b41: UIButton!
    @IBOutlet var b42: UIButton!
    @IBOutlet var b43: UIButton!
    @IBOutlet var b44: UIButton!
    @IBOutlet var b45: UIButton!
    @IBOutlet var b46: UIButton!
    @IBOutlet var b47: UIButton!
    @IBOutlet var b48: UIButton!
    @IBOutlet var b49: UIButton!
    @IBOutlet var b50: UIButton!
    @IBOutlet var b51: UIButton!
    @IBOutlet var b52: UIButton!
    @IBOutlet var b53: UIButton!
    @IBOutlet var b54: UIButton!
    @IBOutlet var b55: UIButton!
    @IBOutlet var b56: UIButton!
    @IBOutlet var b57: UIButton!
    @IBOutlet var b58: UIButton!
    @IBOutlet var b59: UIButton!
    @IBOutlet var b60: UIButton!
    @IBOutlet var b61: UIButton!
    @IBOutlet var b62: UIButton!
    @IBOutlet var b63: UIButton!
    var buttonsArray: [UIButton]!
    
    @IBOutlet var boardImageView: UIImageView!
    @IBOutlet var console: UITextView!
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
    
    var EP: UInt64 = 0
    var CWK: Bool = true
    var CWQ: Bool = true
    var CBK: Bool = true
    var CBQ: Bool = true
    var universalCastleWhiteK: Bool = false
    var universalCastleWhiteQ: Bool = false
    var universalCastleBlackK: Bool = false
    var universalCastleBlackQ: Bool = false
    var whiteToMove: Bool = true
    var whiteInCheck: Bool = false
    var blackInCheck: Bool = false
    
    var playerSelectedSquare: Int?
    var potentialDestinationSquares: [Int]?
    var darkCircleImageViews: [UIImageView] = []
    
    var previousConsoleText: String = "Maestro running..."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        console.delegate = self
        UCI.shared.viewController = self
        BoardGeneration.shared.viewController = self
        Moves.shared.viewController = self
        
        UCI.shared.connect()
        
        buttonsArray = [b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33, b34, b35, b36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47, b48, b49, b50, b51, b52, b53, b54, b55, b56, b57, b58, b59, b60, b61, b62, b63]
        
        //BoardGeneration.shared.importFEN(fenString: "r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R4RK1 b kq - 1 1")
        BoardGeneration.shared.initiateStandardChess()
        BoardGeneration.shared.drawArray(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK)
        /*let start: Date = Date()
        Perft.shared.perftRoot(WP: WP,WN: WN,WB: WB,WR: WR,WQ: WQ,WK: WK,BP: BP,BN: BN,BB: BB,BR: BR,BQ: BQ,BK: BK,EP: EP,CWK: CWK,CWQ: CWQ,CBK: CBK,CBQ: CBQ,whiteToMove: whiteToMove,depth: 0)
        if Perft.shared.perftTotalMoveCounter == 0 {
            if whiteToMove {
                Perft.shared.perftTotalMoveCounter = Moves.shared.possibleMovesW(WP: WP,WN: WN,WB: WB,WR: WR,WQ: WQ,WK: WK,BP: BP,BN: BN,BB: BB,BR: BR,BQ: BQ,BK: BK,EP: EP,CWK: CWK,CWQ: CWQ,CBK: CBK,CBQ: CBQ).count/4
            } else {
                Perft.shared.perftTotalMoveCounter = Moves.shared.possibleMovesB(WP: WP,WN: WN,WB: WB,WR: WR,WQ: WQ,WK: WK,BP: BP,BN: BN,BB: BB,BR: BR,BQ: BQ,BK: BK,EP: EP,CWK: CWK,CWQ: CWQ,CBK: CBK,CBQ: CBQ).count/4
            }
        }
        print("Total: ", Perft.shared.perftTotalMoveCounter, "Took: \(Date().timeIntervalSince(start)) seconds")
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UCI.shared.uciCommunication()
    }
    
    func printToConsole(_ string: String) {
        console.text += "\n\(string)"
        previousConsoleText = console.text.replacingOccurrences(of: "\u{2028}", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    
    @IBAction func goButtonPressed(_ sender: Any) {
        let input = console.text!.replacingOccurrences(of: "\u{2028}", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: previousConsoleText, with: "")
        
        UCI.shared.inputFromUI = input
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CommandEntered"), object: nil)
    }
    
    @IBAction func squareSelected(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        for darkCircleImageView in darkCircleImageViews {
            darkCircleImageView.removeFromSuperview()
        }
        darkCircleImageViews = []
        
        if playerSelectedSquare != button.tag {
            
            if playerSelectedSquare != nil && potentialDestinationSquares!.contains(button.tag) {
                whiteInCheck = false
                blackInCheck = false
                Moves.shared.makeMoveUI(movingSquare: playerSelectedSquare!, destinationSquare: button.tag)
                buttonsArray[playerSelectedSquare!].backgroundColor = nil
                playerSelectedSquare = nil
                draw()
                if Moves.shared.unsafeForWhite(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK) & WK != 0 {
                    whiteInCheck = true
                }
                if Moves.shared.unsafeForBlack(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK) & BK != 0 {
                    blackInCheck = true
                }
                
                if whiteToMove {
                    if whiteInCheck && Moves.shared.possibleK(occupied: WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK, K: WK) == "" {
                        //checkmate, black wins
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let resultViewController = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
                        resultViewController.modalPresentationStyle = .overFullScreen
                        resultViewController.result = .checkmateW
                        present(resultViewController, animated: false, completion: nil)
                    } else if Moves.shared.unsafeForWhite(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK) & WK == 0 && Moves.shared.possibleMovesW(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ) == "" {
                        //stalemate
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let resultViewController = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
                        resultViewController.result = .stalemateW
                        resultViewController.modalPresentationStyle = .overFullScreen
                        present(resultViewController, animated: false, completion: nil)
                    }
                } else {
                    if blackInCheck && Moves.shared.possibleK(occupied: WP|WN|WB|WR|WQ|WK|BP|BN|BB|BR|BQ|BK, K: BK) == "" {
                        //checkmate, white wins
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let resultViewController = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
                        resultViewController.result = .checkmateB
                        resultViewController.modalPresentationStyle = .overFullScreen
                        present(resultViewController, animated: false, completion: nil)
                    } else if Moves.shared.unsafeForBlack(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK) & BK == 0 && Moves.shared.possibleMovesB(WP: WP, WN: WN, WB: WB, WR: WR, WQ: WQ, WK: WK, BP: BP, BN: BN, BB: BB, BR: BR, BQ: BQ, BK: BK, EP: EP, CWK: CWK, CWQ: CWQ, CBK: CBK, CBQ: CBQ) == "" {
                        //stalemate
                        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let resultViewController = storyboard.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
                        resultViewController.result = .stalemateB
                        resultViewController.modalPresentationStyle = .overFullScreen
                        present(resultViewController, animated: false, completion: nil)
                    }
                }
            } else {
                
                if playerSelectedSquare != nil {
                    buttonsArray[playerSelectedSquare!].backgroundColor = nil
                }
                playerSelectedSquare = button.tag
                button.backgroundColor = UIColor.green.withAlphaComponent(0.2)
                potentialDestinationSquares = Moves.shared.getPossibleDestinationSquares(for: button.tag)
                if potentialDestinationSquares != nil {
                    for destinationSquare in potentialDestinationSquares! {
                        let darkCircleImageView: UIImageView = UIImageView(image: UIImage(named: "darkCircle"))
                        let squareWidth = boardImageView.frame.width / 8
                        let x = CGFloat(destinationSquare % 8) * squareWidth
                        let y = CGFloat(destinationSquare / 8) * squareWidth
                        print(x, y)
                        darkCircleImageView.frame = CGRect(x: x, y: y, width: squareWidth, height: squareWidth)
                        boardImageView.addSubview(darkCircleImageView)
                        darkCircleImageViews.append(darkCircleImageView)
                    }
                }
            }
        } else {
            playerSelectedSquare = nil
            button.backgroundColor = nil
        }
    }
    
    func draw() {
        let WPB: String = String(String(WP, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let WNB: String = String(String(WN, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let WBB: String = String(String(WB, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let WRB: String = String(String(WR, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let WQB: String = String(String(WQ, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let WKB: String = String(String(WK, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BPB: String = String(String(BP, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BNB: String = String(String(BN, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BBB: String = String(String(BB, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BRB: String = String(String(BR, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BQB: String = String(String(BQ, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        let BKB: String = String(String(BK, radix: 2).padding(leftTo: 64, withPad: "0", startingAt: 0).reversed())
        
        for i in 0..<64 {
            if WPB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WP"), for: .normal)
            } else if WNB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WN"), for: .normal)
            } else if WBB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WB"), for: .normal)
            } else if WRB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WR"), for: .normal)
            } else if WQB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WQ"), for: .normal)
            } else if WKB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "WK"), for: .normal)
            } else if BPB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BP"), for: .normal)
            } else if BNB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BN"), for: .normal)
            } else if BBB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BB"), for: .normal)
            } else if BRB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BR"), for: .normal)
            } else if BQB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BQ"), for: .normal)
            } else if BKB.charAt(i) == "1" {
                buttonsArray[i].setImage(UIImage(named: "BK"), for: .normal)
            } else {
                buttonsArray[i].setImage(nil, for: .normal)
            }
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            goButtonPressed(self)
            return false
        }
        return true
    }
}

