//
//  BaseViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 18/9/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(completion: @escaping() -> ()) -> Void
    func searchData(query: String, completion: @escaping() -> ()) -> Void
    func search(query: String?, completion: @escaping() -> Void)
    func getCountData() -> Int
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void)
    func getDataCell(at indexPath: IndexPath) -> ResultPhoto
    func changeStateIsFavorite(state: Bool, id: String, completion: (Bool) -> ())
}

class BaseViewModel: HomeViewModelProtocol {
    
    var photos: [ResultPhoto]?
    var photo: Photo?
    
    func getCountData() -> Int {
        photos?.count ?? 0
    }
    
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void) {
        NetworkService.shared.fetchData(id: photos?[indexPath.row].id ?? "") { result in
            switch result {
            case .success(.photo(let data)):
                let viewModel = DetailViewModel(photo: data)
                completion(viewModel)
            case .failure(let err):
                print(err)
            default :
                break
            }
        }
    }
    
    func changeStateIsFavorite(state: Bool, id: String, completion: (Bool) -> ()) {
        if let index = photos?.firstIndex(where: {$0.id == id}) {
            let object = photos?[index]
            UserDefaultsService.shared.saveFavoritePhoto(for: object ?? ResultPhoto(), with: state)
            completion(true)
        } else {
            completion(false)
        }
        
    }
    
    func getDataCell(at indexPath: IndexPath) -> ResultPhoto {
        var cellData = photos?[indexPath.row] ?? ResultPhoto()
        cellData.isFavorite = UserDefaultsService.shared.getFavoritePhoto(for: cellData.id)
        return cellData
    }
    
    func fetchData(completion: @escaping () -> ()) {
        //
    }
    
    func searchData(query: String, completion: @escaping() -> Void) {
        //
    }
    
    func search(query: String?, completion: @escaping() -> Void) {
        //
    }
}
