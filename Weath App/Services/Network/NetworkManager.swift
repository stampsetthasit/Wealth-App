//
//  NetworkManager.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

final class NetworkManager {
    static func fetch<T: Codable>(for url: URL, completion: @escaping (Result<T, HTTPError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(String(describing: error))
                completion(.failure(.error(error: error.localizedDescription)))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let error {
                print(String(describing: error))
                completion(.failure(.decodingError(err: error.localizedDescription)))
            }
        }.resume()
    }
    
    static func fetch<T: Codable, U: Codable>(for url1: URL, for url2: URL, completion: @escaping (Result<(T, U), HTTPError>) -> Void) {
        let group = DispatchGroup()
        var result1: Result<T, HTTPError>?
        var result2: Result<U, HTTPError>?
        
        group.enter()
        fetch(for: url1) { (result: Result<T, HTTPError>) in
            result1 = result
            group.leave()
        }
        
        group.enter()
        fetch(for: url2) { (result: Result<U, HTTPError>) in
            result2 = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            if let result1 = result1, let result2 = result2 {
                switch (result1, result2) {
                case (.success(let data1), .success(let data2)):
                    completion(.success((data1, data2)))
                case (.failure(let error), _), (_, .failure(let error)):
                    completion(.failure(error))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
        }
    }
}
