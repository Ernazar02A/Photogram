//
//  ResultPhoto.swift
//  FinallyApp
//
//  Created by Ernazar on 7/9/23.
//

import Foundation

struct ResultPhotos: Codable {
    let total: Int
    let results: [ResultPhoto]
}

//MARK: - Photo
struct ResultPhoto: Codable {
    var id: String?
    var urls: Urls?
    var user: User?
    var width: Int?
    var height: Int?
    var blurHash: String?
    let createAt: String?
    let likes: Int?
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case likes
        case width
        case height
        case createAt = "created_at"
        case blurHash = "blur_hash"
        case user
    }
    
    init(){
        self.likes = 0
        self.createAt = ""
    }
}


