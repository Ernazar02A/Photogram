//
//  UserDefaultsService.swift
//  FinallyApp
//
//  Created by Ernazar on 5/9/23.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let userDefaults = UserDefaults()
    
    func saveFavoritePhoto(for photoId: String, with status: Bool) {
        userDefaults.set(status, forKey: photoId)
    }
    
    func getFavoritePhoto(photo: Photo, for photoId: String) -> Bool {
        let result = userDefaults.bool(forKey: photoId)
        if result {
            RealmService.shared.saveData(photo: photo)
        } else {
            //RealmService.shared.deleteData(photo: photo)
        }
        return result
    }
}
