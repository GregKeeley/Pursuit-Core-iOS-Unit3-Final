//
//  FavoriteElementsViewController.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class FavoriteElementsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteElements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        ElementAPI.getFavorites(for: "Greg K") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let elements):
                self?.favoriteElements = elements
                dump(elements)
            }
        }
    }
}

extension FavoriteElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteElements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteElementCell", for: indexPath) as? ElementCell else {
            fatalError("Failed to dequeue to ElementCell properly")
        }
        let element = favoriteElements[indexPath.row]
        cell.configureCell(for: element)
        return cell
    }
}
