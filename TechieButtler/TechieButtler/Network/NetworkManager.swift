//
//  NetworkManager.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import Foundation

// MARK: - Network Errors

enum NetworkError: Error {
    case invalidURL
    case requestError(Error)
    case responseError(statusCode: Int)
    case decodingError(Error)
}

// MARK: - NetworkManager

class NetworkManager {

    static let shared = NetworkManager() // Singleton instance

    func fetchData<T: Decodable>(url: URL?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET" // Replace with appropriate HTTP method (GET, POST, etc.)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseError(statusCode: 0))) // Handle unexpected response type
                return
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.responseError(statusCode: httpResponse.statusCode))) // Handle missing data
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                debugPrint(url.absoluteString)
                debugPrint(String(data: data, encoding: .utf8) ?? "")
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }

        task.resume()
    }
}
