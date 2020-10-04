//
//  Player.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class Player {
    var color: UIColor
    var nickname: String
    
    var data: [String: Any] {
        return ["nickname": nickname]
    }
    
    init(color: UIColor, nickname: String) {
        self.color = color
        self.nickname = nickname
    }
    
    convenience init?(data: [String: Any]) {
        guard let nickname = data["nickname"] as? String else {
            return nil
        }
        self.init(color: UIColor.white, nickname: nickname)
    }
    
}
