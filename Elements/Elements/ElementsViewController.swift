//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var elements = [Element]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
   //MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    loadData()
  }
    //MARK: LoadData
    func loadData() {
        ElementAPI.getElements(completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Failure to load elements: \(appError)")
            case .success(let element):
                DispatchQueue.main.async {
                    self?.elements = element
                }
            }
        })
    }
//MARK: PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let elementDVC = segue.destination as? ElementDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Failed to segue to ElementDetailViewController")
        }
        let element = elements[indexPath.row]
        elementDVC.element = element
    }
}

//MARK: Extension
extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath) as? ElementCell else {
            fatalError("Failed to dequeue for ElementCell")
        }
        let element = elements[indexPath.row]
        cell.configureCell(for: element)
        return cell
    }
}
