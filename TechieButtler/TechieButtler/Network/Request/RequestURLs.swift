//
//  Request.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

struct RequestURLs {
    static let posts = Environment.baseURL + "/posts"
    static let comments = RequestURLs.posts + "/{postId}/comments"
}
