//
//  DependencyInjector.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation
import Swinject

class DependencyInjector {
    static let shared = DependencyInjector()
    let container = Container()
    
    private init() {
        container.register(APIService.self) { _ in DefaultAPIService() }
        container.register(PostViewModel.self) { resolver in
            let apiService = resolver.resolve(APIService.self)!
            return PostViewModel(apiService: apiService)
        }
        container.register(CommentViewModel.self) { resolver in
            let apiService = resolver.resolve(APIService.self)!
            return CommentViewModel(apiService: apiService)
        }
    }
}
