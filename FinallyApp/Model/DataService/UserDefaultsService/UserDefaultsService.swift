//
//  UserDefaultsService.swift
//  FinallyApp
//
//  Created by Ernazar on 5/9/23.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let userDefaults = UserDefaults.standard
    private let photoKey = "ArrIdFavorite"
    
    func saveFavoritePhoto(for photo: ResultPhoto, with status: Bool) {
        if status {
            addAndcheckId(id: photo.id + "1")
            do {
                let data = try JSONEncoder().encode(photo)
                userDefaults.set(data, forKey: photo.id + "1")
            } catch {
                print(error)
            }
        } else {
            removeAndcheckId(id: photo.id + "1")
        }
        userDefaults.set(status, forKey: photo.id)
    }
    
    func getFavoritePhoto(photo: ResultPhoto, for photoId: String) -> Bool {
        let result = userDefaults.bool(forKey: photoId)
        return result
    }
    
    private func addAndcheckId(id: String) {
        guard var arr = userDefaults.array(forKey: photoKey) else {return}
        var result = false
        for i in arr {
            if i as? String == id {
                result = true
            }
        }
        if !result {
            arr.append(id)
        }
        userDefaults.set(arr, forKey: photoKey)
    }
    
    private func removeAndcheckId(id: String) {
        guard var arr = userDefaults.array(forKey: photoKey) else {return}
        for (index,i) in arr.enumerated() {
            if i as? String == id {
                arr.remove(at: index)
                break
            }
        }
        userDefaults.set(arr, forKey: photoKey)
    }
    
    func getPhotos() -> [ResultPhoto] {
        guard let arr = userDefaults.array(forKey: photoKey) else {return []}
        var photoArr = [ResultPhoto]()
        for id in arr {
            if let photo = userDefaults.data(forKey: (id as! String)) {
                do {
                    let model = try JSONDecoder().decode(ResultPhoto.self, from: photo)
                    photoArr.append(model)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return photoArr
    }
 }
