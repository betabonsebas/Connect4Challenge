//
//  PlayerViewController.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class PlayerViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet private var setupLabel: UILabel!
    @IBOutlet private var nicknameTextfield: UITextField!
    @IBOutlet private var errorLabel: UILabel!
    
    var viewModel: PlayerViewModel!
    var coordinator: PlayerCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHistoryButton()
    }
    
    func configureUI() {
        setupLabel.text = "Setup \(viewModel.playerToSet())"
        errorLabel.text = ""
    }
    
    func configureHistoryButton() {
        let historyButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(historyAction))
        navigationItem.setRightBarButton(historyButtonItem, animated: false)
    }
    
    @objc func historyAction() {
        coordinator.navigateToHistory()
    }
    
    @IBAction func continueAction(_ sender: Any) {
        errorLabel.text = ""
        guard let nickname = nicknameTextfield.text else {
            errorLabel.text = viewModel.setPlayerErrorText
            return
        }
        
        viewModel.addPlayer(nickname)
        guard viewModel.allPlayerReady() else {
            nicknameTextfield.text = ""
            setupLabel.text = "Setup \(viewModel.playerToSet())"
            return
        }
        
        coordinator.navigateToGame(with: viewModel.players)
    }
}
