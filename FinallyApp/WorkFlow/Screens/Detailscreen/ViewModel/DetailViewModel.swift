//
//  DetailViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

protocol DetailsViewModelProtocol {
    var image: String { get }
    var userName: String { get }
    var userImage: String { get }
    var createDate: String { get }
    var numberOfDownload: String { get }
    var location: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)? { get set }
    func favoriteButtonTapped()
    init(photo: Photo)
}

class DetailViewModel: DetailsViewModelProtocol {
    var userName: String {
        photo.user.name
    }
    var userImage: String {
        photo.user.profileImage["medium"]!
    }
    var createDate: String {
        let date = FormatService.shared.stringToDate(dateString: photo.createAt)
        let month = FormatService.shared.monthText(monthNumber: date.month)
        return "Опубликовано в \(month) \(date.day!),\(date.year!)"
    }
    var numberOfDownload: String {
        "\(photo.downloads) Скачиваний"
    }
    var location: String {
        photo.location.name ?? ""
    }
    var image: String {
        photo.urls["small"] ?? ""
    }
    var isFavorite: Bool {
        get {
            let photo = getPhoto()
            return UserDefaultsService.shared.getFavoritePhoto(photo: photo, for: photo.id)
        } set {
            let photo = getPhoto()
            UserDefaultsService.shared.saveFavoritePhoto(for: photo, with: newValue)
            viewModelDidChange?(self)
        }
    }
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)?
    private let photo: Photo
    
    required init(photo: Photo) {
        self.photo = photo
    }
    
    private func getPhoto() -> ResultPhoto {
        var photo = ResultPhoto()
        photo.id = self.photo.id
        photo.user.name = self.photo.user.name
        photo.urls = self.photo.urls
        return photo
    }
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
    }
}
