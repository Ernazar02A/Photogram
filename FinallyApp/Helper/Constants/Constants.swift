//
//  Constants.swift
//  FinallyApp
//
//  Created by Ernazar on 24/8/23.
//

import Foundation

enum Constants {
    enum APIKEY {
        static let AccessKey = "PT4CxtdJOpxeUVguQn-yrfAy9fjNW8c15rDq9qbtjVE"
        static let SecretKey = "ovdBCuTvv1Wwn9O7ik8yGnj6GR5km8MjkU55F96uLkA"
    }
    
    enum APIURL {
        static let baseUrl = "https://api.unsplash.com"
        static func randomUrl(count: Int) -> URL {
            return URL(string: "\(baseUrl)/photos/random/?count=\(count)&client_id=\(Constants.APIKEY.AccessKey)")!
        }
        static func searchUrl(query: String) -> URL {
            return URL(string: "\(baseUrl)/search/photos/?query=\(query)&client_id=\(Constants.APIKEY.AccessKey)") ?? randomUrl(count: 20)
        }
        static func getPhotoUrl(id: String) -> URL {
            return URL(string: "\(baseUrl)/photos/\(id)/?client_id=\(Constants.APIKEY.AccessKey)")!
        }
    }
}
