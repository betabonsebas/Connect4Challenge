//
//  GameViewModel.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class GameViewModel {
    private enum Constants {
        static let rows: Int = 6
        static let columns: Int = 7
    }
    
    var chips: [Chip] = []
    private var playerOneCount: Int = 0
    private var playerTwoCount: Int = 0
    private var turn: Int = 0
    private var columns: [Int: Int] = [0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1]
    
    var playerOne: Player
    var playerTwo: Player
    
//    let firebase: FirebaseController
    
    var updateUI: ((_ player: Player) -> ())? {
        didSet {
            updateUI?(playerInTurn())
        }
    }
    
    var showWinner: ((_ player: Player) -> ())?
    
    init(players: [Player]) {
        self.playerOne = players[0]
        self.playerTwo = players[1]
//        firebase = FirebaseController()
        buildBoardArray()
    }
    
    private func buildBoardArray() {
        for row in stride(from: Constants.rows, to: 0, by: -1) {
            for column in stride(from: 0, to: Constants.columns, by: 1) {
                let chip = Chip(color: .lightGray, position: (row, column))
                chips.append(chip)
            }
        }
    }
    
    func add(to column: Int) {
        guard let rowValue = columns[column] else {
            return
        }
        
        let player = playerInTurn()
        let position: (row: Int, column: Int) = (rowValue, column)
        updatePlayerCount(player)
        updateChips(with: player.color, position: position)
        columns[column] = columns[column]! + 1
    }
    
    private func updatePlayerCount(_ player: Player) {
        if player.color == playerOne.color {
            playerOneCount += 1
        } else {
            playerTwoCount += 1
        }
    }
    
    private func updateChips(with color: UIColor, position: (row: Int, column: Int)) {
        for chip in chips {
            if chip.position.row == position.row && chip.position.column == position.column {
                chip.color = color
            }
        }
        isWinner(Chip(color: color, position: position))
        turn += 1
        updateUI?(playerInTurn())
    }
    
    private func playerInTurn() -> Player {
        if turn % 2 == 0 {
            return playerOne
        }
        return playerTwo
    }
    
    func isWinner(_ chip: Chip) {
        guard playerOneCount >= 4 || playerTwoCount >= 4 else {
            return
        }
        
        if foundInColumn(with: chip) || foundInRow(with: chip) || foundInFirstDiagonal(with: chip) || foundInSecondDiagonal(with: chip) {
            let winner = playerInTurn()
//            firebase.saveGame(Game(playerOne: playerOne.nickname, playerTwo: playerTwo.nickname, playerOneChips: playerOneCount, playerTwoChips: playerTwoCount, winner: winner.nickname))
            showWinner?(winner)
            return
        } else {
            return
        }
    }
    
    func foundInColumn(with chip: Chip) -> Bool {
        guard chip.position.row >= 4 else {
            return false
        }
        
        var columnCount = 0
        for row in stride(from: chip.position.row, to: 0, by: -1) {
            guard let _ = chips.first(where: {$0.position.row == row && $0.position.column == chip.position.column && chip.color == $0.color }) else {
                return false
            }
            columnCount += 1
        }
        
        return columnCount >= 4
    }
    
    func foundInRow(with chip: Chip) -> Bool {
        var countPieces = 0
        for column in stride(from: chip.position.column, through: 0, by: -1) {
            guard let _ = chips.first(where: {$0.position.row == chip.position.row && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            countPieces += 1
        }

        guard countPieces < 4 else {
            return true
        }

        for column in stride(from: chip.position.column + 1, to: Constants.columns, by: 1) {
            guard let _ = chips.first(where: {$0.position.row == chip.position.row && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            countPieces += 1
        }

        guard countPieces < 4 else {
            return true
        }

        return false
    }
    
    func foundInFirstDiagonal(with chip: Chip) -> Bool {
        var countPieces = 1
        var minusRow = chip.position.row - 1
        for column in stride(from: chip.position.column - 1, through: 0, by: -1) {
            guard let _ = chips.first(where: {$0.position.row == minusRow && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            minusRow -= 1
            countPieces += 1
        }
        
        guard countPieces < 4 else {
            return true
        }
        
        var plusRow = chip.position.row + 1
        for column in stride(from: chip.position.column + 1, to: Constants.columns, by: 1) {
            guard let _ = chips.first(where: {$0.position.row == plusRow && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            plusRow += 1
            countPieces += 1
        }
        
        guard countPieces < 4 else {
            return true
        }
        
        return false
    }
    
    func foundInSecondDiagonal(with chip: Chip) -> Bool {
        var countPieces = 1
        var plusRow = chip.position.row + 1
        for column in stride(from: chip.position.column - 1, through: 0, by: -1) {
            guard let _ = chips.first(where: {$0.position.row == plusRow && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            
            plusRow += 1
            countPieces += 1
        }
        
        guard countPieces < 4 else {
            return true
        }
        
        var minusRow = chip.position.row - 1
        for column in stride(from: chip.position.column + 1, to: Constants.columns, by: 1) {
            guard let _ = chips.first(where: {$0.position.row == minusRow && $0.position.column == column && $0.color == chip.color}) else {
                break
            }
            
            minusRow -= 1
            countPieces += 1
        }
        
        guard countPieces < 4 else {
            return true
        }
        
        return false
    }
}
