//
//  DetailViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

protocol DetailsViewModelProtocol {
    var image: String { get }
    var blurHash: String { get }
    var height: Int { get }
    var width: Int { get }
    var userName: String { get }
    var userImage: String { get }
    var createDate: String { get }
    var numberOfDownload: String { get }
    var location: String { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)? { get set }
    func getCountData() -> Int
    func getDataCell(at indexPath: IndexPath) -> ResultPhoto
    func getdidSelectItem(at indexPath: IndexPath, completion: @escaping () -> ())
    func favoriteButtonTapped()
    func getUserPhotos(completion: @escaping() -> ()) -> Void
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
        photo.urls.small
    }
    var width: Int {
        photo.width / 120
    }
    var height: Int {
        photo.height / 120
    }
    var blurHash: String {
        photo.blurHash
    }
    var isFavorite: Bool {
        get {
            let photo = getPhoto()
            return UserDefaultsService.shared.getFavoritePhoto( for: photo.id)
        } set {
            let photo = getPhoto()
            UserDefaultsService.shared.saveFavoritePhoto(for: photo, with: newValue)
            viewModelDidChange?(self)
        }
    }
    private var userPhotos: [ResultPhoto] = []
    var viewModelDidChange: ((DetailsViewModelProtocol) -> Void)?
    private var photo: Photo
    
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
    
    func getUserPhotos(completion: @escaping () -> ()) {
        NetworkService.shared.fetchDataByUsername(username: photo.user.userName ?? "") { [weak self] result in
            switch result {
            case .success(.resultPhotoArr(let datas)):
                self?.userPhotos = datas
                completion()
            case .failure(let err):
                print(err)
            default :
                break
            }
        }
    }
    
    func getdidSelectItem(at indexPath: IndexPath, completion: @escaping () -> ()) {
        NetworkService.shared.fetchDataById(id: userPhotos[indexPath.row].id) {[weak self] result in
            switch result {
            case .success(.photo(let data)):
                self?.photo = data
                completion()
            case .failure(let err):
                print(err.localizedDescription)
            default:
                break
            }
        }
    }
    
    func getCountData() -> Int {
        return userPhotos.count
    }
    
    func getDataCell(at indexPath: IndexPath) -> ResultPhoto {
        return userPhotos[indexPath.row]
    }
    
    func favoriteButtonTapped() {
        isFavorite.toggle()
    }
}
