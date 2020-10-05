//
//  GameTableViewCell.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var chips1Label: UILabel!
    @IBOutlet weak var chips2Label: UILabel!
    
    func configure(with game: Game) {
        winnerLabel.text = "winner: \(game.winner)"
        player1Label.text = "Player One: \(game.playerOne)"
        player2Label.text = "Player Two: \(game.playerTwo)"
        chips1Label.text = "Chips: \(game.playerOneChips)"
        chips2Label.text = "Chips: \(game.playerTwoChips)"
    }
    
}
