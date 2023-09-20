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
    let createAt: String
    let likes: Int
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case likes
        case createAt = "created_at"
        case user
    }
    
    init() {
        self.id = ""
        self.urls = Urls()
        self.likes = 0
        self.createAt = ""
        self.user = User()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.createAt = try container.decode(String.self, forKey: .createAt)
        self.likes = try container.decode(Int.self, forKey: .likes)
        self.user = try container.decode(User.self, forKey: .user)
    }
}


