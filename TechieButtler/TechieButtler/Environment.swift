//
//  TechieButtlerEnvironment.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

enum Environment {

    static var baseURL: String {
        guard let infoDictionary = Bundle.main.infoDictionary else {
            fatalError("plist not found")
        }

        guard let baseURLString = infoDictionary["Root_URL"] as? String else {
            fatalError("key not found")
        }

        return baseURLString
    }
}
