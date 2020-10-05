//
//  PlayerCoordinator.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class PlayerCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
    }
    
    func rootPresenter() -> UINavigationController {
        return self.presenter
    }
    
    func navigate() {
        let viewController = PlayerViewController.fromStoryboard()
        viewController.viewModel = PlayerViewModel()
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
    
    func navigateToGame(with players: [Player]) {
        let coordinator = GameCoordinator(presenter: self.presenter, players: players)
        coordinator.navigate()
    }
    
    func navigateToHistory() {
        let coordinator = HistoryCoordinator(presenter: self.presenter)
        coordinator.navigate()
    }
}
