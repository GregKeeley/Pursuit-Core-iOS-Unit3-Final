//
//  ImageAPI.swift
//  Elements
//
//  Created by Gregory Keeley on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

class getImage {
    static func getThumbnail(for urlString: String, completion: @escaping (Result<UIImage?, AppError>) -> ()) {
        guard let url = URL(string: urlString) else {
            print("bard url: \(urlString)")
        }
        
    }
}
