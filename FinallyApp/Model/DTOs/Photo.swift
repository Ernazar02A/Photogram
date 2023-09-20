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
    var createAt: String
    var width: Int
    var height: Int
    var blurHash: String
    let description: String?
    var urls: Urls
    var user: User
    var downloads: Int
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id
        case createAt = "created_at"
        case width
        case height
        case blurHash = "blur_hash"
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
        self.width = 0
        self.height = 0
        self.blurHash = ""
        self.urls = Urls()
        self.user = User()
        self.downloads = 0
        self.location = Location()
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.urls = try container.decode(Urls.self.self, forKey: .urls)
        self.user = try container.decode(User.self, forKey: .user)
        self.createAt = try container.decode(String.self, forKey: .createAt)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.blurHash = try container.decode(String.self, forKey: .blurHash)
        self.location = try container.decode(Location.self, forKey: .location)
        self.downloads = try container.decode(Int.self, forKey: .downloads)
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    init() {
        self.raw = "raw"
        self.full = "full"
        self.regular = "regular"
        self.small = "small"
        self.thumb = "thumb"
        self.smallS3 = "smallS3"
    }
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

//MARK: - User
struct User: Codable {
    let id: String
    var name: String
    var userName: String?
    let profileImage: [String : String]
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case profileImage = "profile_image"
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.userName = ""
        self.profileImage = ["":""]
    }
}

// MARK: - Location
struct Location: Codable {
    var name: String?
    init() {
        self.name = ""
    }
}
