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
    var id: String
    var urls: Urls
    var user: User
    var width: Int
    var height: Int
    var blurHash: String
    let createAt: String
    let likes: Int
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
    
    init() {
        self.id = ""
        self.urls = Urls()
        self.likes = 0
        self.width = 0
        self.height = 0
        self.blurHash = ""
        self.createAt = ""
        self.user = User()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.createAt = try container.decode(String.self, forKey: .createAt)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.blurHash = try container.decode(String.self, forKey: .blurHash)
        self.likes = try container.decode(Int.self, forKey: .likes)
        self.user = try container.decode(User.self, forKey: .user)
    }
}


