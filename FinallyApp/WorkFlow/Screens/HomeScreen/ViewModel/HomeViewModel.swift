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
    func getData(at indexPath: IndexPath) -> Photo
    func getViewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol
}


class HomeViewModel: HomeViewModelProtocol {
    
    private var photos: [Photo]?
    private var result: [ResultPhoto]?
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
                self?.result = data
                completion()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func search(query: String?, completion: @escaping() -> Void) {
        guard let text = query else { return }
        if !text.isEmpty {
            isSearch.toggle()
            searchData(query: text, completion: completion)
        } else {
            isSearch.toggle()
        }
    }
    
    func getCountData() -> Int {
        //isSearch ? photos?.count ?? 0 : result?.count ?? 0
        photos?.count ?? 0
    }
    
    func getData(at indexPath: IndexPath) -> Photo {
        //isSearch ? photos?[indexPath.row] ?? Photo() : result?[indexPath.row] ?? ResultPhoto()
        return photos?[indexPath.row] ?? Photo()
    }
    
    func getViewModelForSelectedRow(at indexPath: IndexPath) -> DetailsViewModelProtocol {
        let photo = photos?[indexPath.row] ?? Photo()
        print(photo)
        return DetailViewModel(photo: photo)
    }
}
