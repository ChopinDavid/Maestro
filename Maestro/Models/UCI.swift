//
//  UCI.swift
//  Maestro2
//
//  Created by David G Chopin on 3/12/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import Foundation

class UCI {
    static var shared: UCI = UCI()
    let engineName: String = "Maestro v1"
    var viewController: ViewController!
    var inputFromUI: String!
    func connect() {
        NotificationCenter.default.addObserver(self, selector: #selector(uciCommunication), name: NSNotification.Name(rawValue: "CommandEntered"), object: nil)
    }
    @objc func uciCommunication() {
        if inputFromUI != nil {
            if self.inputFromUI.lowercased() == "uci" {
                self.inputUCI()
            } else if self.inputFromUI.lowercased().starts(with: "setoption") {
                self.inputSetOption(inputString: self.inputFromUI)
            } else if self.inputFromUI.lowercased() == "isready" {
                self.inputIsReady()
            } else if self.inputFromUI.lowercased() == "ucinewgame" {
                self.inputUCINewGame()
            } else if self.inputFromUI.lowercased().starts(with: "position") {
                self.inputPosition(input: self.inputFromUI)
            } else if self.inputFromUI.lowercased() == "go" {
                self.inputGo()
            } else if self.inputFromUI.lowercased() == "print" {
                self.inputPrint()
            }
            self.inputFromUI = nil
        }
    }
    func inputUCI() {
        print("id name \(engineName)")
        viewController.printToConsole("id name \(engineName)")
        print("id author David Chopin")
        viewController.printToConsole("id author David Chopin")
        print("uciok")
        viewController.printToConsole("uciok")
        viewController.printToConsole("\n")
    }
    func inputSetOption(inputString: String) {
        //set options
    }
    func inputIsReady() {
        print("readyok")
        viewController.printToConsole("readyok")
        viewController.printToConsole("\n")
    }
    func inputUCINewGame() {
        //add code here
    }
    func inputPosition(input: String) {
        var input: String = input
        input = "\(input[9..<input.count - 1]) "
        if input.contains("startpos ") {
            input = input[9..<input.count - 1]
            BoardGeneration.shared.importFEN(fenString: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
        }
        else if input.contains("fen") {
            input = input[4..<input.count - 1]
            BoardGeneration.shared.importFEN(fenString: input)
        }
        if input.contains("moves") {
            input = input[input.distance(from: input.startIndex, to: input.index(of: "moves")!) + 6..<input.count - 1]
            //make each of the moves
        }
    }
    func inputGo() {
        //search for best move
    }
    func inputPrint() {
        BoardGeneration.shared.drawArray(WP: viewController.WP,WN: viewController.WN,WB: viewController.WB,WR: viewController.WR,WQ: viewController.WQ,WK: viewController.WK,BP: viewController.BP,BN: viewController.BN,BB: viewController.BB,BR: viewController.BR,BQ: viewController.BQ,BK: viewController.BK)
    }
}
