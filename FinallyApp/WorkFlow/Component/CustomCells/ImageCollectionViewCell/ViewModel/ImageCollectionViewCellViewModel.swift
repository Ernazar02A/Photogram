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
        photo.urls.thumb
    }
    var userName: String {
        photo.user.name
    }
    var userImage: String {
        photo.user.profileImage["small"]!
    }
    var isFavorite: Bool {
        get {
            let photo = getPhoto()
            return UserDefaultsService.shared.getFavoritePhoto(for: photo.id)
        } set {
            let photo = getPhoto()
            UserDefaultsService.shared.saveFavoritePhoto(for: photo, with: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var viewModelDidChange: ((ImageCollectionViewCellViewModelProtocol) -> Void)?
    private var photo: ResultPhoto!
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
    }
    
    private func getPhoto() -> ResultPhoto {
        var photo = ResultPhoto()
        photo.id = self.photo.id
        photo.user.name = self.photo.user.name
        photo.urls = self.photo.urls
        return photo
    }
    
    private func saveIsFavorite(isFavorite: Bool, id: String) {
        if isFavorite {
            
        } else {
            
        }
    }
    
    required init(photo: ResultPhoto) {
        self.photo = photo
    }
}
