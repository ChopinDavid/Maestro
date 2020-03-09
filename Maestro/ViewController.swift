//
//  ViewController.swift
//  Maestro2
//
//  Created by David G Chopin on 3/7/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let boardGeneration = BoardGeneration()
        boardGeneration.initiateStandardChess()
    }
}

