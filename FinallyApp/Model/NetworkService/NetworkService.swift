//
//  NetworkService.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import Foundation

enum TypePhoto {
    case resultPhotoArr([ResultPhoto])
    case photo(Photo)
}

class NetworkService {
    
    static let shared = NetworkService()
    
    func request(url: URL, completion: @escaping (Result<TypePhoto,Error>) -> Void, handler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            handler(safeData)
        }
        task.resume()
    }
}
