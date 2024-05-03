//
//  PostViewModel.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation
import Combine

class PostViewModel {
    private let apiService: APIService?

    private var currentPage: Int = 0
    private var isLoading: Bool = false
    var dataSubject = PassthroughSubject<[PostDetailModel], Never>()
    var errorSubject = PassthroughSubject<Error, Never>()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    private func fetchData() {
        guard !isLoading else { return } // Prevent redundant requests while loading
        isLoading = true
        
        if let posts = CacheManager.shared.getPosts(for: currentPage) {
            let postDetails = posts.map { PostDetailModel(post: $0, color: pastelColors.randomElement() ?? .white) }
            dataSubject.send(postDetails)
            return
        }

        apiService?.fetchPosts(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            defer { self.isLoading = false } // Set loading state to false after completion
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    let posts = data.map { PostDetailModel(post: $0, color: pastelColors.randomElement() ?? .white) }
                    CacheManager.shared.savePosts(data, for: self?.currentPage)
                    self?.dataSubject.send(posts)
                    
                case .failure(let error):
                    self?.errorSubject.send(error)
                }
            }
        }
    }
    
    func loadNextPage() {
        if isLoading { return }
        currentPage += 1 
        
        fetchData()
    }

}
