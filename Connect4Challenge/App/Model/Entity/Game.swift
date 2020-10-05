//
//  Game.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import Foundation

class Game {
    let playerOne: String
    let playerTwo: String
    let playerOneChips: Int
    let playerTwoChips: Int
    let winner: String
    
    var data: [String: Any] {
        var game: [String: Any] = [:]
        game["playerOne"] = playerOne
        game["playerTwo"] = playerTwo
        game["playerOneChips"] = playerOneChips
        game["playerTwoChips"] = playerTwoChips
        game["winner"] = winner
        return game
    }
    
    init(playerOne: String, playerTwo: String, playerOneChips: Int, playerTwoChips: Int, winner: String) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerOneChips = playerOneChips
        self.playerTwoChips = playerTwoChips
        self.winner = winner
    }
    
    convenience init?(data: [String: Any]) {
//        print(data["winner"] as? String)
        guard let one = data["playerOne"] as? String,
        let two = data["playerTwo"] as? String,
        let oneCount = data["playerOneChips"] as? Int,
        let twoCount = data["playerTwoChips"] as? Int,
            let winner = data["winner"] as? String else {
                return nil
        }
        self.init(playerOne: one, playerTwo: two, playerOneChips: oneCount, playerTwoChips: twoCount, winner: winner)
    }
    
}
