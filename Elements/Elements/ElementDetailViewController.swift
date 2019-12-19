//
//  ElementDetailViewController.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var boilingPointLabel: UILabel!
    @IBOutlet weak var meltingPointLabel: UILabel!
    @IBOutlet weak var discoverdByLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var element: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.isEditable = false
        loadData()
    }
    
    func loadData() {
        navigationItem.title = element?.name
        symbolLabel.text = element?.symbol
        numberLabel.text = element?.number.description ?? "N/A"
        weightLabel.text = ("Mass: \(element?.atomicMass?.description ?? "N/A")")
        boilingPointLabel.text = ("Boiling Point: \(element?.boil?.description ?? "N/A")")
        meltingPointLabel.text = ("Boiling Point: \(element?.melt?.description ?? "N/A")")
        discoverdByLabel.text = element?.discoveredBy
        descriptionTextView.text = element?.summary
        elementImage.getImage(with: "http://images-of-elements.com/\(String(describing: element?.name?.lowercased() ?? "argon")).jpg") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
                DispatchQueue.main.async {
                    self?.elementImage.image = UIImage(systemName: "exclamation-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImage.image = image
                }
            }
        }
    }
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let favoritedBy = "Greg K"
        guard let element = element else {
            print("Error- No element to favorite")
            return
        }
        let favoriteElement = Element(name: element.name, atomicMass: element.atomicMass, boil: element.boil, discoveredBy: element.discoveredBy, melt: element.melt, number: element.number, summary: element.summary, symbol: element.symbol, category: element.category, period: element.period, molarHeat: element.molarHeat, phase: element.phase, source: element.source, appearance: element.appearance, density: element.density, favoritedBy: favoritedBy)
        ElementAPI.postFavorite(element: favoriteElement) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                 DispatchQueue.main.async {
                                   self?.showAlert(title: "Error", message: "\(appError)")
                               }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Successful", message: "You have successfully submitted your favorite element")
                }
                
            }
        }
    }

}
