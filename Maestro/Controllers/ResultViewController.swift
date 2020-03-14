//
//  ResultViewController.swift
//  Maestro2
//
//  Created by David G Chopin on 3/13/20.
//  Copyright © 2020 David G Chopin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var label: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    var result: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        switch result {
        case .checkmateW:
            label.text = "Checkmate, black wins!"
        case .checkmateB:
            label.text = "Checkmate, white wins!"
        case .stalemateW:
            label.text = "Draw, white has no moves, but isn't in check..."
        case .stalemateB:
            label.text = "Draw, black has no moves, but isn't in check..."
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playAgainButton.layer.cornerRadius = playAgainButton.frame.height / 2
    }
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

enum Result {
    case checkmateW, checkmateB, stalemateW, stalemateB
}
