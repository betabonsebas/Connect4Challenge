//
//  Chip.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class Chip {
    var color: UIColor
    var position: (row: Int, column: Int)
    
    init(color: UIColor, position: (row: Int, column: Int)) {
        self.color = color
        self.position = position
    }
}
