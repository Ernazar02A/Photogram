//
//  HomeViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

protocol FetchDataProtocol {
    func fetchData(completion: @escaping() -> Void)
}

protocol HomeViewModelProtocol {
    func searchData(query: String, completion: @escaping() -> ()) -> Void
    func search(query: String?, completion: @escaping() -> Void)
}

class HomeViewModel: BaseViewModel, HomeViewModelProtocol , FetchDataProtocol {
    
    private var isSearch: Bool = false
    
    func fetchData(completion: @escaping() -> Void) {
        DataService.shared.fetchRandomData { [weak self] result in
            self?.setData(result: result, completion: completion)
        }
    }
    
    func searchData(query: String, completion: @escaping() -> Void) {
        DataService.shared.searchData(query: query) { [weak self] result in
            self?.setData(result: result, completion: completion)
        }
    }
    
    private func setData(result: Result<TypePhoto, Error>, completion: @escaping() -> Void) {
        switch result {
        case .success(.resultPhotoArr(let data)):
            photos = data
            completion()
        case .failure(let err):
            print(err)
        default :
            break
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
}
