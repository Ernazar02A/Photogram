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
        
        static var randomUrl: (Int) -> String = { count in
            "\(baseUrl)/photos/random/?count=\(count)&client_id=\(Constants.APIKEY.AccessKey)"
        }
        
        static var searchUrl: (String) -> String = { query in
            "\(baseUrl)/search/photos/?query=\(query)&client_id=\(Constants.APIKEY.AccessKey)"
        }
        
        static var getPhotoUrl: (String) -> String = { id in
            "\(baseUrl)/photos/\(id)/?client_id=\(Constants.APIKEY.AccessKey)"
        }
        
        static var getUserPhotosUrl: (String) -> String = { userName in
            "\(baseUrl)/users/\(userName)/photos/?client_id=\(Constants.APIKEY.AccessKey)"
        }
    }
    
    enum SizesSpacingImageColletionViewLayout {
        static let itemSpacing: CGFloat = 10
        static let lineSpacing: CGFloat = 10
        enum EdgeInsetsSpacings {
            static let top = 0
            static let left: CGFloat = 20
            static let bottom = 0
            static let right: CGFloat = 20
        }
        static let countItem = 2
        //static let widthItem = itemSpacing * 2
    }
}
