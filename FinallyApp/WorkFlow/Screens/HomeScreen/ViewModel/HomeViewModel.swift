//
//  HomeViewModel.swift
//  FinallyApp
//
//  Created by Ernazar on 1/9/23.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    private var isSearch: Bool = false
    
    override func fetchData(completion: @escaping() -> Void) {
        NetworkService.shared.fetchRandomData { [weak self] result in
            self?.setData(result: result, completion: completion)
        }
    }
    
    override func searchData(query: String, completion: @escaping() -> Void) {
        NetworkService.shared.searchData(query: query) { [weak self] result in
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
    
    override func search(query: String?, completion: @escaping() -> Void) {
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
