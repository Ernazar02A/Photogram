//
//  ImageCollectionViewCellViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 8/9/23.
//

import Foundation

protocol ImageCollectionViewCellViewModelProtocol {
    var image: String { get }
    var userName: String { get }
    var userImage: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((ImageCollectionViewCellViewModelProtocol) -> Void)? { get set }
    func favoriteButtonTapped()
    init(photo: ResultPhoto)
}
class ImageCollectionViewCellViewModel: ImageCollectionViewCellViewModelProtocol {
    
    var image: String {
        photo.urls["thumb"]!
    }
    var userName: String {
        photo.user.name
    }
    var userImage: String {
        photo.user.profileImage["small"]!
    }
    var isFavorite: Bool {
        get {
            var ob = Photo()
            ob.id = photo.id
            ob.user.name = photo.user.name
            ob.urls = photo.urls
            return UserDefaultsService.shared.getFavoritePhoto(photo: ob, for: photo.id)
        } set {
            UserDefaultsService.shared.saveFavoritePhoto(for: photo.id, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((ImageCollectionViewCellViewModelProtocol) -> Void)?
    private var photo: ResultPhoto!
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
    }
    
    required init(photo: ResultPhoto) {
        self.photo = photo
    }
}
