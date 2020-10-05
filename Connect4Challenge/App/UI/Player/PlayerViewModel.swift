//
//  PlayerViewModel.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class PlayerViewModel {
    private let fetcher: FirebaseFetcher
    private var playerOne: Player?
    private var playerTwo: Player?
    var setPlayerErrorText: String
    
    /// Call this property always after check if all the players are set
    var players: [Player] {
        return [playerOne!, playerTwo!]
    }
    
    init() {
        fetcher = FirebaseFetcher()
        self.setPlayerErrorText = "Please add your nickname"
    }
    
    func addPlayer(_ nickname: String) {
        if playerOne == nil {
            playerOne = Player(color: UIColor.blue, nickname: nickname)
            fetcher.savePlayer(playerOne!)
            return
        }
        
        if playerTwo == nil {
            playerTwo = Player(color: UIColor.red, nickname: nickname)
            fetcher.savePlayer(playerTwo!)
            return
        }
    }
    
    func allPlayerReady() -> Bool {
        if playerOne == nil || playerTwo == nil {
            return false
        }
        return true
    }
    
    func playerToSet() -> String {
        if playerOne == nil {
            return "Player One"
        }
        
        if playerTwo == nil {
            return "Player Two"
        }
        
        return ""
    }
}
