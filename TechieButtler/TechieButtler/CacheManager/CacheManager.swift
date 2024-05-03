//
//  CacheManager.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    private var postCatche = [Int: [Post]]()
    private var commentCatche = [Int: [Comment]]()
    
    private init() {
    }

    func savePosts(_ posts: [Post], for page: Int?) {
        postCatche[page ?? 1] = posts
    }
    
    func getPosts(for page: Int?) -> [Post]? {
        return postCatche[page ?? 1]
    }
    
    func saveComments(_ comments: [Comment], for id: Int?) {
        commentCatche[id ?? .zero] = comments
    }
    
    func getComments(for id: Int?) -> [Comment]? {
        return commentCatche[id ?? .zero]
    }
}
