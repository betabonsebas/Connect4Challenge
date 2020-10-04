//
//  PlayerViewModel.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class PlayerViewModel {
//    private let firebase: FirebaseController
    private var playerOne: Player?
    private var playerTwo: Player?
    var setPlayerErrorText: String
    
    /// Call this property always after check if all the players are set
    var players: [Player] {
        return [playerOne!, playerTwo!]
    }
    
    init() {
//        firebase = FirebaseController()
        self.setPlayerErrorText = "Please add your nickname"
    }
    
    func addPlayer(_ nickname: String) {
        if playerOne == nil {
            playerOne = Player(color: UIColor.blue, nickname: nickname)
//            firebase.savePlayer(playerOne!)
            return
        }
        
        if playerTwo == nil {
            playerTwo = Player(color: UIColor.red, nickname: nickname)
//            firebase.savePlayer(playerTwo!)
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
    
//    func gameControllerWithPlayers() -> GameController? {
//        guard let playerOne = self.playerOne, let playerTwo = self.playerTwo else {
//            return nil
//        }
//        
//        return GameController(playerOne: playerOne, playerTwo: playerTwo)
//    }
}
