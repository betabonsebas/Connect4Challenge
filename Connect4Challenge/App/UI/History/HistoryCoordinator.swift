//
//  HistoryCoordinator.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class HistoryCoordinator: Coordinator {
    private let presenter: UINavigationController
    private let players: [Player]
    
    init(presenter: UINavigationController = UINavigationController(), players: [Player]) {
        self.presenter = presenter
        self.players = players
    }
    
    func navigate() {
        let viewController = HistoryViewController.fromStoryboard()
        viewController.viewModel = HistoryViewModel()
        viewController.coordinator = self
        presenter.pushViewController(viewController, animated: true)
    }
}
