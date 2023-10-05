//
//  BaseViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 18/9/23.
//

import Foundation

protocol BaseViewModelProtocol {
    var getCountData: Int {get}
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void)
    func getDataCell(at indexPath: IndexPath) -> ResultPhoto
    func changeStateIsFavorite(state: Bool, id: String, completion: (Bool) -> ())
}

class BaseViewModel: BaseViewModelProtocol {
    
    var photos: [ResultPhoto]?
    var photo: Photo?
    
    var getCountData: Int {
        photos?.count ?? 0
    }
    
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void) {
        DataService.shared.fetchDataById(id: photos?[indexPath.row].id ?? "") { result in
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
}
