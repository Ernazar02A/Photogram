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
    var id: String?
    var createAt: String?
    var width: Int?
    var height: Int?
    var blurHash: String?
    var description: String?
    var urls: Urls?
    var user: User?
    var downloads: Int?
    var location: Location?
    
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
