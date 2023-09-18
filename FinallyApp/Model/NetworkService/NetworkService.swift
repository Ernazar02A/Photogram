//
//  NetworkService.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private func request(url: URL, completion: @escaping (Result<[ResultPhoto],Error>) -> Void, handler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            handler(safeData)
        }
        task.resume()
    }
    
    func fetchRandomData(completion: @escaping (Result<[ResultPhoto],Error>) -> Void) {
        let url = Constants.APIURL.randomUrl(count: 20)
        request(url: url, completion: completion) { data in 
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode([ResultPhoto].self, from: data)
                completion(.success(models))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchData(query: String, completion: @escaping (Result<[ResultPhoto],Error>) -> Void) {
        let url = Constants.APIURL.searchUrl(query: query)
        
        request(url: url, completion: completion) { data in
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(ResultPhotos.self, from: data)
                completion(.success(models.results))

            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchData(id: String, completion: @escaping (Result<Photo,Error>) -> Void) {
        let url = Constants.APIURL.getPhotoUrl(id: id)
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(Photo.self, from: safeData)
                completion(.success(models))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
