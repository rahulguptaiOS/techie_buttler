//
//  Utilities.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation
import UIKit

class Utilities {
    static func presentErrorAlert(with error: Error) -> UIAlertController {
        let alert = UIAlertController(title: Titles.error, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok, style: .default, handler: nil))
        return alert
    }
}
