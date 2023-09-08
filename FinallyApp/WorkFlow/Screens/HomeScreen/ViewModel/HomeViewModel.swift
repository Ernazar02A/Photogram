//
//  HomeViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func fetchData(completion: @escaping() -> ()) -> Void
    func searchData(query: String, completion: @escaping() -> ()) -> Void
    func search(query: String?, completion: @escaping() -> Void)
    func getCountData() -> Int
    func getViewModelForSelectedRow(at indexPath: IndexPath, completion: @escaping (DetailsViewModelProtocol) -> Void)
    func getViewModelForCell(at indexPath: IndexPath) -> ImageCollectionViewCellViewModelProtocol
}


class HomeViewModel: HomeViewModelProtocol {
    
    private var photos: [ResultPhoto]?
    private var photo: Photo?
    private var isSearch: Bool = false
    
    func fetchData(completion: @escaping() -> Void) {
        NetworkService.shared.fetchRandomData { [weak self] result in
            switch result {
            case .success(let data):
                self?.photos = data
                completion()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func searchData(query: String, completion: @escaping() -> Void) {
        NetworkService.shared.SearchData(query: query) { [weak self] result in
            switch result {
            case .success(let data):
                self?.photos = data
                completion()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func search(query: String?, completion: @escaping() -> Void) {
        guard let text = query else { return }
        if text.count > 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.isSearch.toggle()
                self?.searchData(query: text, completion: completion)
            }
        } else {
            isSearch.toggle()
        }
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
