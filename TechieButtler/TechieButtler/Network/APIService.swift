//
//  APIService.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

protocol APIService {
    func fetchPosts(page: Int, completion: @escaping (Result<[Post], NetworkError>) -> Void)
    func fetchComments(id: Int?, completion: @escaping (Result<[Comment], NetworkError>) -> Void)
}

class DefaultAPIService: APIService {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }

    func fetchPosts(page: Int, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: RequestURLs.posts)
        let requestModel = PaginationRequestModel(page: page, limit: 10)
        urlComponents?.queryItems = requestModel.queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        self.networkManager.fetchData(url: urlComponents?.url, completion: completion)
    }
    
    func fetchComments(id: Int?, completion: @escaping (Result<[Comment], NetworkError>) -> Void) {
        let url = URL(string: RequestURLs.comments.replacingOccurrences(of: "{postId}", with: "\(id ?? .zero)"))
        self.networkManager.fetchData(url: url, completion: completion)
    }
}
