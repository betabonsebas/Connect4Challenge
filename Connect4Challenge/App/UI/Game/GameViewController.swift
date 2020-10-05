//
//  GameViewController.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class GameViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet var playerOneLabel: UILabel!
    @IBOutlet var playerOneChips: UILabel!
    
    @IBOutlet var playerTwoLabel: UILabel!
    @IBOutlet var playerTwoChips: UILabel!
    
    @IBOutlet var playerTurnLabel: UILabel!
    
    // Rows
    @IBOutlet var row1Button: UIButton!
    @IBOutlet var row2Button: UIButton!
    @IBOutlet var row3Button: UIButton!
    @IBOutlet var row4Button: UIButton!
    @IBOutlet var row5Button: UIButton!
    @IBOutlet var row6Button: UIButton!
    @IBOutlet var row7Button: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var winnerLabel: UILabel!
    
    var coordinator: GameCoordinator!
    var viewModel: GameViewModel! {
        didSet {
            loadViewIfNeeded()
            
            viewModel.updateUI = { [weak self] (player, count) in
                self?.collectionView.reloadData()
                self?.setupCurrentPlayer(player)
                self?.setupCount(count)
            }
            
            viewModel.showWinner = { [weak self] player in
                self?.showWinner(player)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winnerLabel.text = ""
        setupPlayers()
        setupCollectionView()
    }
    
    private func setupPlayers() {
        playerOneLabel.text = viewModel.playerOne.nickname
        playerOneLabel.textColor = viewModel.playerOne.color
        
        playerTwoLabel.text = viewModel.playerTwo.nickname
        playerTwoLabel.textColor = viewModel.playerTwo.color
    }
    
    private func setupCount(_ count: (one: Int, two: Int)) {
        playerOneChips.text = "\(count.one)"
        playerTwoChips.text = "\(count.two)"
    }
    
    private func setupCurrentPlayer(_ player: Player) {
        playerTurnLabel.text = "Turn for: \(player.nickname)"
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        let chipNib = UINib(nibName: String(describing: ChipCollectionViewCell.self), bundle: nil)
        collectionView.register(chipNib, forCellWithReuseIdentifier: String(describing: ChipCollectionViewCell.self))
    }
    
    private func showWinner(_ winner: Player) {
        let alert = UIAlertController(title: "Winner", message: "\(winner.nickname) wins!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addChipToRowAction(_ sender: UIButton) {
        var selectedColumn: Int = 0
        switch sender {
        case row1Button:
            selectedColumn = 0
            break
        case row2Button:
            selectedColumn = 1
            break
        case row3Button:
            selectedColumn = 2
            break
        case row4Button:
            selectedColumn = 3
            break
        case row5Button:
            selectedColumn = 4
            break
        case row6Button:
            selectedColumn = 5
            break
        case row7Button:
            selectedColumn = 6
            break
        default:
            break
        }
        viewModel.add(to: selectedColumn)
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.chips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ChipCollectionViewCell.self), for: indexPath) as! ChipCollectionViewCell
        let chip = viewModel.chips[indexPath.item]
        cell.configure(with: chip)
        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideSize = (view.frame.width / 7) - 10
        return CGSize(width: sideSize, height: sideSize)
    }
}
