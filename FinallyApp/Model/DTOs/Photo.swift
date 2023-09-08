//
//  Photo.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

struct Photos: Codable {
    let total: Int
    let results: [Photo]
}

//MARK: - Photo
struct Photo: Codable {
    var id: String
    let createAt: String
    let description: String?
    var urls: [String : String]
    var user: User
    let downloads: Int
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case createAt = "created_at"
        case description
        case urls
        case user
        case location
        case downloads
    }
    
    init() {
        self.id = ""
        self.createAt = ""
        self.description = ""
        self.urls = ["":""]
        self.user = User()
        self.downloads = 0
        self.location = Location()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.urls = try container.decode([String : String].self, forKey: .urls)
        self.user = try container.decode(User.self, forKey: .user)
        self.createAt = try container.decode(String.self, forKey: .createAt)
        self.location = try container.decode(Location.self, forKey: .location)
        self.downloads = try container.decode(Int.self, forKey: .downloads)
    }
}

//MARK: - User
struct User: Codable {
    let id: String
    var name: String
    let profileImage: [String : String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImage = "profile_image"
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.profileImage = ["":""]
    }
}

// MARK: - Location
struct Location: Codable {
    var name: String?
    init() {
        self.name = "name"
    }
}
