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
    var isFavorite: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
    }
    
    init() {
        self.id = ""
        self.urls = Urls()
        self.user = User()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.urls = try container.decode(Urls.self, forKey: .urls)
        self.user = try container.decode(User.self, forKey: .user)
    }
}


