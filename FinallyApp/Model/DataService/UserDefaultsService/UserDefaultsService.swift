//
//  UserDefaultsService.swift
//  FinallyApp
//
//  Created by Ernazar on 5/9/23.
//

import Foundation

class UserDefaultsService {
    enum DeleteOrAdd {
        case add
        case remove
    }
    static let shared = UserDefaultsService()
    private let userDefaults = UserDefaults.standard
    private let photoKey = "ArrIdFavorite"
    
    func saveFavoritePhoto(for photo: ResultPhoto, with status: Bool) {
        if status {
            changeState(id: photo.id, operation: .add)
            do {
                let data = try JSONEncoder().encode(photo)
                userDefaults.set(data, forKey: photo.id + "1")
            } catch {
                print(error)
            }
        } else {
            changeState(id: photo.id, operation: .remove)
        }
        userDefaults.set(status, forKey: photo.id)
    }
    
    func getFavoritePhoto(for photoId: String) -> Bool {
        userDefaults.bool(forKey: photoId)
    }
    
    private func changeState(id: String, operation: DeleteOrAdd) {
        guard var arr = userDefaults.array(forKey: photoKey)  as? [String] else { return }
        let index = arr.firstIndex(where: {$0 == id + "1"})
        switch operation {
        case .add:
            if index == nil {
                arr.append(id + "1")
            }
        case .remove:
            if let index = index {
                arr.remove(at: index)
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
