//
//  FirebaseFetcher.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import Foundation
import Firebase

class FirebaseFetcher {
    private let db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func savePlayer(_ player: Player) {
        db.collection("player").addDocument(data: player.data)
    }
    
    func saveGame(_ game: Game) {
        db.collection("game").addDocument(data: game.data)
    }
    
    func getPlayers(completion: @escaping (_ players: [Player]?) -> ()) {
        db.collection("player").getDocuments { (snapshot, error) in
            guard error == nil, let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            
            var players: [Player] = []
            for document in documents {
                if let player = Player(data: document.data()) {
                    players.append(player)
                }
            }
            completion(players)
        }
    }
    
    func getPlayer(for nickName: String, completion: @escaping(_ player: Player?) -> ()) {
        let query = db.collection("player").whereField("nickname", isEqualTo: nickName)
        query.getDocuments { (snapshot, error) in
            guard error == nil, let document = snapshot?.documents.first else {
                completion(nil)
                return
            }
            
            guard let player = Player(data: document.data()) else {
                completion(nil)
                return
            }
            
            completion(player)
        }
    }
    
    func getGames(completion: @escaping(_ player: [Game]?) -> ()) {
        db.collection("game").getDocuments { (snapshot, error) in
            guard error == nil, let documents = snapshot?.documents else {
                completion(nil)
                return
            }
            
            var games: [Game] = []
            for document in documents {
                if let game = Game(data: document.data()) {
                    games.append(game)
                }
            }
            completion(games)
        }
    }
}
