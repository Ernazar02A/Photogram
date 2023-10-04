//
//  DataService.swift
//  FinallyApp
//
//  Created by Ernazar on 4/10/23.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    
    let decoder = JSONDecoder()
    
    func fetchRandomData(completion: @escaping (Result<TypePhoto,Error>) -> Void) {

        let url = Constants.APIURL.randomUrl(count: 20)
        
        NetworkService.shared.request(url: url, completion: completion) { data in
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
        
        NetworkService.shared.request(url: url, completion: completion) { [unowned self] data in
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
        
        NetworkService.shared.request(url: url, completion: completion) { [unowned self] data in
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
        
        NetworkService.shared.request(url: url, completion: completion) { [unowned self] data in
            do {
                let models = try self.decoder.decode([ResultPhoto].self, from: data)
                completion(.success(.resultPhotoArr(models)))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
