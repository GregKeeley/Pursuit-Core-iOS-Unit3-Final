//
//  UIImageViewExtension.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

extension UIImageView {
    func getImage(with urlString: String, completion: @escaping (Result<UIImage, AppError>) -> ()) {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .green
        activityIndicator.startAnimating()
        activityIndicator.center = center
        addSubview(activityIndicator)
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            switch result {
            case .failure(let appError):
                completion(.failure(.networkError(appError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
     
}
