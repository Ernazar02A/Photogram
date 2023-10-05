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
    let photoKey = "ArrIdFavorite"
    let keyAddition = "1"
    lazy var keyForOnlySave: (String?) -> String? = {[unowned self] id in
        guard let id = id else {return nil}
        return id + self.keyAddition
    }
    
    func saveFavoritePhoto(for photo: ResultPhoto?, with status: Bool) {
        guard let model = photo else { return }
        if status {
            changeState(id: model.id, operation: .add)
            do {
                let data = try JSONEncoder().encode(model)
                if let key = keyForOnlySave(model.id) {
                    userDefaults.set(data, forKey: key)
                } else {
                    print("nil id")
                }
                
            } catch {
                print(error)
            }
        } else {
            changeState(id: model.id, operation: .remove)
        }
        userDefaults.set(status, forKey: model.id ?? "")
    }
    
    func getFavoritePhoto(for photoId: String?) -> Bool {
        guard let id = photoId else {return false}
        return userDefaults.bool(forKey: id)
    }
    
    private func changeState(id: String?, operation: DeleteOrAdd) {
        guard let id = id else {return}
        guard var arr = userDefaults.array(forKey: photoKey)  as? [String] else { return }
        let index = arr.firstIndex(where: {$0 == id + keyAddition})
        switch operation {
        case .add:
            if index == nil {
                if let key = keyForOnlySave(id) {
                    arr.append(key)
                } else {
                    print("find nil")
                }
            }
        case .remove:
            if let index = index {
                arr.remove(at: index)
            }
        }
        userDefaults.set(arr, forKey: photoKey)
    }
    
    func getPhotos() -> [ResultPhoto] {
        guard let arr = userDefaults.array(forKey: photoKey) as? [String] else {return []}
        var photoArr = [ResultPhoto]()
        for id in arr {
            if let photo = userDefaults.data(forKey: id) {
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
