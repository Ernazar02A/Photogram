//
//  DataService.swift
//  FinallyApp
//
//  Created by Ernazar on 5/9/23.
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private let userDefaults = UserDefaults()
    
    func saveFavoritePhoto(for photoId: String, with status: Bool) {
        userDefaults.set(status, forKey: photoId)
    }
    
    func getFavoritePhoto(for photoId: String) -> Bool {
        userDefaults.bool(forKey: photoId)
    }
}
