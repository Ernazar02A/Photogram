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
    
    let decoder = JSONDecoder()
    
    private func request(url: URL, completion: @escaping (Result<TypePhoto,Error>) -> Void, handler: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let err = error {
                print(err.localizedDescription)
            }
            guard let safeData = data else { return }
            handler(safeData)
        }
        task.resume()
    }
    
    func fetchRandomData(completion: @escaping (Result<TypePhoto,Error>) -> Void) {
        let url = Constants.APIURL.randomUrl(count: 20)
        request(url: url, completion: completion) { data in 
            do {
                let models = try self.decoder.decode([ResultPhoto].self, from: data)
                completion(.success(.resultPhotoArr(models)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchData(query: String, completion: @escaping (Result<TypePhoto,Error>) -> Void) {
        let url = Constants.APIURL.searchUrl(query: query)
        
        request(url: url, completion: completion) { [unowned self] data in
            do {
                let models = try self.decoder.decode(ResultPhotos.self, from: data)
                completion(.success(.resultPhotoArr(models.results)))

            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchDataById(id: String, completion: @escaping (Result<TypePhoto,Error>) -> Void) {
        let url = Constants.APIURL.getPhotoUrl(id: id)
        
        request(url: url, completion: completion) { [unowned self] data in
            do {
                let model = try self.decoder.decode(Photo.self, from: data)
                completion(.success(.photo(model)))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetchDataByUsername(username: String, completion: @escaping (Result<TypePhoto,Error>) -> Void) {
        let url = Constants.APIURL.getUserPhotosUrl(userName: username)
        
        request(url: url, completion: completion) { [unowned self] data in
            do {
                let models = try self.decoder.decode([ResultPhoto].self, from: data)
                completion(.success(.resultPhotoArr(models)))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
