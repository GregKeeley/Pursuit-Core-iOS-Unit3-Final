//
//  ElementDetailTableViewCell.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    func configureCell(for element: Element) {
        nameLabel.text = element.name
        symbolLabel.text = ("Symbol: \(element.symbol)")
        weightLabel.text = ("Mass: \(element.atomicMass.description)")
        numberLabel.text = ("No. \(element.number.description)")
        elementImage.getImage(with: "http://www.theodoregray.com/periodictable/Tiles/\(String(format: "%03d",(element.number)))/s7.JPG") { [weak self] (result) in
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
}
