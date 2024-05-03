//
//  Comments.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

struct Comment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
}
