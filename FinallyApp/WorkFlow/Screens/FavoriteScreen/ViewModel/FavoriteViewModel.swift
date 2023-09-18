//
//  FavoriteViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 27/8/23.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func fetchData(completion: @escaping() -> ()) -> Void
    func getCountData() -> Int
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void)
    func getViewModelForCell(at indexPath: IndexPath) -> ImageCollectionViewCellViewModelProtocol
}


class FavoriteViewModel: FavoriteViewModelProtocol {
    
    private var photos: [ResultPhoto]?
    private var photo: Photo?
    
    func fetchData(completion: @escaping() -> Void) {
        photos = UserDefaultsService.shared.getPhotos()
        completion()
    }
    
    func getCountData() -> Int {
        photos?.count ?? 0
    }
    
    func getViewModelForCell(at indexPath: IndexPath) -> ImageCollectionViewCellViewModelProtocol {
        let viewModel = ImageCollectionViewCellViewModel(photo: photos?[indexPath.row] ?? ResultPhoto())
        return viewModel
    }
    
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void) {
        NetworkService.shared.fetchData(id: photos?[indexPath.row].id ?? "") { result in
            switch result {
            case .success(let data):
                let viewModel = DetailViewModel(photo: data)
                completion(viewModel)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
