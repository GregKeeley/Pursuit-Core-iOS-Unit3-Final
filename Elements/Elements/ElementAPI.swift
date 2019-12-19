//
//  ElementAPI.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct ElementAPI {
    
    //MARK: GET Elements
    static func getElements(completion: @escaping (Result<[Element], AppError>) -> ()) {
        let elementEndpointURL = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements"
        guard let url = URL(string: elementEndpointURL) else {
            completion(.failure(.badURL(elementEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(appError))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    completion(.success(elements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    
    
    // MARK: POST Favorite
    static func postFavorite(element: Element, completion: @escaping (Result<Bool, AppError>) -> ()) {
        let postEndpoint = "http://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        guard let url = URL(string: postEndpoint) else {
            completion(.failure(.badURL(postEndpoint)))
            return
        }
        do {
            let data = try JSONEncoder().encode(element)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkError(appError)))
                case .success:
                    completion(.success(true))
                }
            }
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    // MARK: GET Favorites
    static func getFavorites(for user: String, completion: @escaping (Result<[Element], AppError>) -> ()) {
        let endpointURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkError(appError)))
            case .success(let data):
                do {
                    let elements = try JSONDecoder().decode([Element].self, from: data)
                    let usersElements = elements.filter { $0.favoritedBy == user }
                    completion(.success(usersElements))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
}

