//
//  PaginationRequestModel.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

struct PaginationRequestModel: Encodable {
    let page: Int
    let limit: Int

    var queryParams: [String: String] {
        return ["_page": String(page), "_limit": String(limit)]
    }
}

