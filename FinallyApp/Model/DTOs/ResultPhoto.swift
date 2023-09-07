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
    let id: String
    let createAt: String
    let description: String?
    let urls: [String : String]
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case createAt = "created_at"
        case description
        case urls
        case user
    }
    
    init() {
        self.id = ""
        self.createAt = ""
        self.description = ""
        self.urls = ["":""]
        self.user = User()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.urls = try container.decode([String : String].self, forKey: .urls)
        self.user = try container.decode(User.self, forKey: .user)
        self.createAt = try container.decode(String.self, forKey: .createAt)
    }
}
