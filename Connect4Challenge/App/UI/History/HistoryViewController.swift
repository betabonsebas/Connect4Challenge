//
//  HistoryViewController.swift
//  Connect4Challenge
//
//  Created by Sebastian Bonilla on 4/10/20.
//

import UIKit

class HistoryViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet var tableview: UITableView!
//    private var firebase: FirebaseController!
//    private var games: [Game] = []
    
    var coordinator: HistoryCoordinator!
    var viewModel: HistoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        firebase = FirebaseController()
        tableview.dataSource = self
        let nib = UINib(nibName: String(describing: GameTableViewCell.self), bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: String(describing: GameTableViewCell.self))
        self.fillData()
    }
    
    private func fillData() {
//        firebase.getGames { [weak self] (games) in
//            guard let gamesToShow = games else {
//                return
//            }
//            self?.games = gamesToShow
//            self?.tableview.reloadData()
//        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return games.count
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: String(describing: GameTableViewCell.self)) as! GameTableViewCell
        return cell
    }
    
}
