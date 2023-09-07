//
//  NetworkService.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchRandomData(completion: @escaping (Result<[Photo],Error>) -> Void) {
        let url = Constants.APIURL.randomUrl(count: 20)
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            do {
                print(safeData)
                let decoder = JSONDecoder()
                let models = try decoder.decode([Photo].self, from: safeData)
                completion(.success(models))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func SearchData(query: String, completion: @escaping (Result<[ResultPhoto],Error>) -> Void) {
        let url = Constants.APIURL.searchUrl(query: query)
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            do {
                print(safeData)
                let decoder = JSONDecoder()
                let models = try decoder.decode(ResultPhotos.self, from: safeData)
                completion(.success(models.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
