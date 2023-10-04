//
//  FavoriteViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import Foundation

class FavoriteViewModel: BaseViewModel, FetchDataProtocol {
    func fetchData(completion: @escaping () -> ()) {
        photos = UserDefaultsService.shared.getPhotos()
        completion()
    }
}
