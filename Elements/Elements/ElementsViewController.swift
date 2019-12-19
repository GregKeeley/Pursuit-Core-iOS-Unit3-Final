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
                self.navigationItem.title = ("Elements: \(self.elements.count)")
            }
        }
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadData()
    }
    //MARK: Funcs
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
        ElementAPI.getAdditionalElements(completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                self?.showAlert(title: "Error", message: "Failed to load elements(\(appError))")
                print("Failure to load elements: \(appError)")
            case .success(let element):
                    for item in element {
                        self?.elements.append(item)
                    
                }
            }
        } )
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

extension ElementsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
    }
}
