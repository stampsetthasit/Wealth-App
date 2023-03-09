//
//  NetworkManager.swift
//  Weath App
//
//  Created by Setthasit Poosawat on 9/3/23.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, HTTPError>) -> Void) {
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
}
