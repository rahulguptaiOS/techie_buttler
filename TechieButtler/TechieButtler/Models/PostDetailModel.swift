//
//  PostDetailModel.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation
import UIKit

struct PostDetailModel {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    let color: UIColor?
    var identifier: String? {
        "\(id ?? 0)"
    }
    
    var userIdentifier: String? {
        "\(userId ?? 0)"
    }
    
    init(post: Post, color: UIColor) {
        self.userId = post.userId
        self.id = post.id
        self.title = post.title
        self.body = post.body
        self.color = color
    }
}
