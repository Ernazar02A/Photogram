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

        guard let url = URL(string:Constants.APIURL.randomUrl(20)) else {
            print("error url")
            return
        }
        
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
        guard let url = URL(string:Constants.APIURL.searchUrl(query)) else {
            print("error url")
            return
        }
        
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
        guard let url = URL(string:Constants.APIURL.getPhotoUrl(id)) else {
            print("error url")
            return
        }
        
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
        guard let url = URL(string:Constants.APIURL.getUserPhotosUrl(username)) else {
            print("error url")
            return
        }
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
