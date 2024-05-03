//
//  CommentViewModel.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation
import Combine

class CommentViewModel {
    private let apiService: APIService?
    var dataSubject = PassthroughSubject<[Comment], Never>()
    var errorSubject = PassthroughSubject<Error, Never>()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    private func fetchData(id: Int?) {
        if let comments = CacheManager.shared.getComments(for: id) {
            dataSubject.send(comments)
            return
        }
        
        apiService?.fetchComments(id: id) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    CacheManager.shared.saveComments(data, for: id)
                    self?.dataSubject.send(data)
                    
                case .failure(let error):
                    self?.errorSubject.send(error)
                }
            }
        }
    }
    
    func loadComments(id: Int?) {
        fetchData(id: id)
    }

}

